-- --------------------------- --
--  *** Example SQL Script *** --
-- --------------------------- --

SELECT col_1, col_2, AVG(col_3)
FROM example_db.tbl_1
GROUP BY col_1, col_2
WHERE col_1 LIKE '%this%';