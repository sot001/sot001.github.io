Specify input file delimiter with -F;

`cat inputfile.csv | awk -F, '{print "this is the first field:"$1}'`

`this is the first field:South Africa`

write apostrophes out by escaping and wrapping in quotes '\\'';

`cat inputfile.csv | awk -F, '{print "insert into SALES_PRODUCTTYPE (TYPECODE) values ('\''"$2"'\'')"}'`

`insert into SALES_PRODUCTTYPE (TYPECODE) values ('Camping')`