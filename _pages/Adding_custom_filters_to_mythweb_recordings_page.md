All filters are read from the recordfilter table;

    mysql> select * from recordfilter;
    +----------+----------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------+
    | filterid | description          | clause                                                                                                                                                                                                    | newruledefault |
    +----------+----------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------+
    |        0 | New episode          | program.previouslyshown = 0                                                                                                                                                                               |              0 |
    |        1 | Identifiable episode | program.generic = 0                                                                                                                                                                                       |              0 |
    |        2 | First showing        | program.first > 0                                                                                                                                                                                         |              0 |
    |        3 | Prime time           | HOUR(CONVERT_TZ(program.starttime, 'Etc/UTC', 'SYSTEM')) >= 19 AND HOUR(CONVERT_TZ(program.starttime, 'Etc/UTC', 'SYSTEM')) < 22                                                                          |              0 |
    |        4 | Commercial free      | channel.commmethod = -2                                                                                                                                                                                   |              0 |
    |        5 | High definition      | program.hdtv > 0                                                                                                                                                                                          |              0 |
    |        6 | This episode         | (RECTABLE.programid <> '' AND program.programid = RECTABLE.programid) OR (RECTABLE.programid = '' AND program.subtitle = RECTABLE.subtitle AND program.description = RECTABLE.description)                |              0 |
    |        7 | This series          | (RECTABLE.seriesid <> '' AND program.seriesid = RECTABLE.seriesid)                                                                                                                                        |              0 |
    |        8 | This time            | ABS(TIMESTAMPDIFF(MINUTE, CONVERT_TZ(  ADDTIME(RECTABLE.startdate, RECTABLE.starttime), 'Etc/UTC', 'SYSTEM'),   CONVERT_TZ(program.starttime, 'Etc/UTC', 'SYSTEM'))) MOD 1440   NOT BETWEEN 11 AND 1429   |              0 |
    |        9 | This day and time    | ABS(TIMESTAMPDIFF(MINUTE, CONVERT_TZ(  ADDTIME(RECTABLE.startdate, RECTABLE.starttime), 'Etc/UTC', 'SYSTEM'),   CONVERT_TZ(program.starttime, 'Etc/UTC', 'SYSTEM'))) MOD 10080   NOT BETWEEN 11 AND 10069 |              0 |
    |       10 | This channel         | channel.callsign = RECTABLE.station                                                                                                                                                                       |              0 |
    +----------+----------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------+
    11 rows in set (0.00 sec)

So simply insert a new row into the table;

    mysql> insert into recordfilter values (11, "No Signage", "program.subtitletypes <> 'SIGNED'", 1);

You'll then need to add a translation to the appropriate langauge file
found in /var/www/html/mythweb/modules/_shared/lang. English.lang
(default) for example. Insert a line to reflect the description given
above in the sql table;

    "No Signage"

### back filling new filters

filters are stored in the record table as a bit value. each filter in
the recordfilter table corresponds to a bit values. eg;

    mysql> select filterid, description, power(2, filterid) as bit from recordfilter;
    +----------+----------------------+------+
    | filterid | description          | bit  |
    +----------+----------------------+------+
    |        0 | New episode          |    1 |
    |        1 | Identifiable episode |    2 |
    |        2 | First showing        |    4 |
    |        3 | Prime time           |    8 |
    |        4 | Commercial free      |   16 |
    |        5 | High definition      |   32 |
    |        6 | This episode         |   64 |
    |        7 | This series          |  128 |
    |        8 | This time            |  256 |
    |        9 | This day and time    |  512 |
    |       10 | This channel         | 1024 |
    |       11 | No Signage           | 2048 |
    +----------+----------------------+------+
    12 rows in set (0.01 sec)

so to set all recordings to apply filter number 11 (no signage) simply
add 2048 to the existing filter;

    mysql> update record set filter = filter+2048 where filter < 2048;