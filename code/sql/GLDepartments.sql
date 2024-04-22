
-- =============================================
-- gl_departments
--
-- Purpose: Stores all GL Departments for GL Transactions for DS2 - GL Transactions Dataset
-- Created By: AB (20240419)

-- Modified By:
-- YYYYMMDD (XX): Added columns XXX for DSX - XXX Dataset.

-- =============================================

SELECT 
    om.[omoperatingunitnumber]  AS  [department_code] 
    ,dp.[name]                  AS  [department_name]
FROM [omoperatingunit] om 
INNER JOIN [dirpartytable] dp 
    ON om.[recid] = dp.[recid]
WHERE [omoperatingunittype] = 1 -- Needed for filtering to departments
ORDER BY 1
;
