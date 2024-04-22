-- =============================================
-- gl_sources
--
-- Purpose: Stores all GL Sources for GL Transactions for DS2 - GL Transactions Dataset
-- Created By: AB (20240419)

-- Modified By:
-- YYYYMMDD (XX): Added columns XXX for DSX - XXX Dataset.

-- =============================================


SELECT 
	[journalname] AS [gl_source_code]
	,[name]	AS [gl_source_name]
FROM ledgerjournalname
WHERE 	
	-- Not deleted record
	IsDelete IS NULL
