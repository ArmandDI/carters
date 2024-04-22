-- =============================================
-- gl_accounts
--
-- Purpose: Stores all GL Accounts for GL Transactions for DS2 - GL Transactions Dataset
-- Created By: JS (20240419)

-- Modified By:
-- YYYYMMDD (XX): Added columns XXX for DSX - XXX Dataset.

-- =============================================

SELECT 
	ma.[mainaccountid] AS [gl_main_account],
	ma.[consolidationmainaccount] AS [consolidation_main_account],
	ma.[name] AS [gl_account_name],
	mac.[accountcategory] AS [gl_account_category],
	ma.[type] AS [gl_account_type]
FROM mainaccount ma 
	LEFT JOIN mainaccountcategory mac 
		ON ma.[accountcategoryref] = mac.[accountcategoryref]
WHERE 
	-- Not deleted record
	ma.IsDelete IS NULL
	AND mac.IsDelete IS NULL
