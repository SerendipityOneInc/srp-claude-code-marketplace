BEGIN
--   select selected_columns;
  FOR column_name IN (SELECT * FROM UNNEST(selected_columns)) DO
    select column_name;
  END FOR;
END