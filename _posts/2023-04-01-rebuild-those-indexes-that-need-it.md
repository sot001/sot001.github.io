---
title: rebuild-those-indexes-that-need-it
date: '2023-04-01 19:37:57 +0000'
categories:
- rebuild-those-indexes-that-need-it
tags:
- rebuild-those-indexes-that-need-it
---


```

DECLARE @objectid int;
DECLARE @indexid int;
DECLARE @partitioncount bigint;
DECLARE @schemaname nvarchar(130);
DECLARE @objectname nvarchar(130);
DECLARE @indexname nvarchar(130);
DECLARE @partitionnum bigint;
DECLARE @partitions bigint;
DECLARE @frag float;
DECLARE @command nvarchar(4000);
DECLARE @HasBlobColumn int;

-- Tuning constants
declare @MaxFragmentation int = 10 --Change this value to adjust the threshold for fragmentation
declare @RebuildThreshold int = 30 --Change this value to adjust the break point for defrag/rebuild
declare @TrivialPageCount int = 500 --Change this value to adjust the size threshold

-- Conditionally select tables and indexes from the sys.dm_db_index_physical_stats function
SELECT
    object_id AS objectid,
    index_id AS indexid,
    partition_number AS partitionnum,
    avg_fragmentation_in_percent AS frag
INTO #work_to_do
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'LIMITED') f
WHERE avg_fragmentation_in_percent > @MaxFragmentation
    AND index_id > 0 -- cannot defrag a heap
    AND page_count > @TrivialPageCount -- ignore trivial sized indexes

while exists (select * from #work_to_do)
begin
    SELECT top 1
            @objectid = WTD.objectid,
            @indexid = WTD.indexid,
            @partitionnum = WTD.partitionnum,
            @frag  = WTD.frag
    FROM #work_to_do WTD
        INNER JOIN sys.indexes I ON I.object_id = WTD.objectid
    WHERE I.is_disabled = 0 AND I.is_hypothetical = 0;

    SET @HasBlobColumn = 0 -- reinitialize
    SELECT
        @objectname = QUOTENAME(o.name),
        @schemaname = QUOTENAME(s.name)
    FROM sys.objects AS o
        JOIN sys.schemas AS s ON s.schema_id = o.schema_id
    WHERE o.object_id = @objectid;

    SELECT
        @indexname = QUOTENAME(name)
    FROM sys.indexes
    WHERE object_id = @objectid
        AND index_id = @indexid;

    SELECT @partitioncount = count (*)
    FROM sys.partitions
    WHERE object_id = @objectid
        AND index_id = @indexid;

    SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname;
    IF @frag > @RebuildThreshold
        SET @command = @command + N' REBUILD WITH( SORT_IN_TEMPDB = ON) '
    ELSE
        SET @command = @command + N' REORGANIZE'

    IF @partitioncount > 1
        SET @command = @command + N' PARTITION=' + CAST(@partitionnum AS nvarchar(10));

    PRINT N'Executing: ' + @command ;
    begin try
        EXEC (@command)
    end try
    begin catch
        print 'cannot execute ' + @command
        print ERROR_MESSAGE()
    end catch

    delete from #work_to_do
    where objectid = @objectid and
            indexid = @indexid and
            partitionnum = @partitionnum and
            frag = @frag
end

drop table #work_to_do
```