---
title: changing-default-start-early--end-late-settings
date: '2023-04-01 19:37:55 +0000'
categories:
- changing-default-start-early--end-late-settings
tags:
- changing-default-start-early--end-late-settings
---


can be done via the front end, but also can be done via MySQL;

find the template in the record table;

    mysql> select * from record where title like 'Default%' \G
    *************************** 1. row ***************************
         recordid: 2302
             type: 11
           chanid: 0
        starttime: 07:23:56
        startdate: 2014-09-06
          endtime: 07:23:56
          enddate: 2014-09-06
            title: Default (Template)
    ....
        maxnewest: 0
      startoffset: 5
        endoffset: 5
         recgroup: Default
    ......

Change as required (eg, 1 minute offset);

    mysql> update record set startoffset = 1, endoffset = 1 where recordid = 2302;