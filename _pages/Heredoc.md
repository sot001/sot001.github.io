    SQL-CMD = <<<SQL
    select *
      from $tablename
     where id in [$order_ids_list]
       and product_name = "widgets"
    SQL;