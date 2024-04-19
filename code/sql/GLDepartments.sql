
-- =============================================
-- gl_departments
--
-- Purpose: Stores all GL Departments for GL Transactions for DS2 - GL Transactions Dataset
-- Created By: AB (20240419)

-- Modified By:
-- YYYYMMDD (XX): Added columns XXX for DSX - XXX Dataset.

-- =============================================

SELECT 
	 [recid] AS [department_key]
	--,[OMOPERATINGUNITNUMBER] AS [department_code] -- No Department code found in fabric data - atleast none that align to codes in power bi output.
	,[name] AS [department_name]
	--,CONCAT([OMOPERATINGUNITNUMBER], ' ', [name]) AS [department_code_name] -- removed as a result of not having a department code.
	--,DataLakeModified_DateTime AS [_updated_date]
FROM dirpartytable