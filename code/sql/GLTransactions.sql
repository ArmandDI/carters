
-- =============================================
-- gl_transactions
--
-- Purpose: Stores all GL Sources for GL Transactions for DS2 - GL Transactions Dataset
-- Created By: AB (20240422)

-- Modified By:
-- YYYYMMDD (XX): Added columns XXX for DSX - XXX Dataset.

-- =============================================


WITH select_generaljournalaccountentry AS
(
SELECT 
[ledgeraccount]
,SUBSTRING([ledgeraccount], 0, CHARINDEX('-', [ledgeraccount], 1)) AS [ledgeraccountpt1]
,SUBSTRING([ledgeraccount], PATINDEX('%-%', [ledgeraccount]) + 1, 2) AS [ledgeraccountpt2]
,SUBSTRING(SUBSTRING([ledgeraccount], (LEN(CONCAT((SUBSTRING([ledgeraccount], 0, CHARINDEX('-', [ledgeraccount], 1))), '-', (SUBSTRING([ledgeraccount], PATINDEX('%-%', [ledgeraccount]) + 1, 2)))) + 2), PATINDEX('%-%', [ledgeraccount])), 0, CHARINDEX('-', SUBSTRING([ledgeraccount], (LEN(CONCAT((SUBSTRING([ledgeraccount], 0, CHARINDEX('-', [ledgeraccount], 1))), '-', (SUBSTRING([ledgeraccount], PATINDEX('%-%', [ledgeraccount]) + 1, 2)))) + 2), PATINDEX('%-%', [ledgeraccount])), 1)) AS [ledgeraccountpt3]
,SUBSTRING([ledgeraccount], CHARINDEX('-', [ledgeraccount], (CHARINDEX('-', [ledgeraccount], (CHARINDEX('-', [ledgeraccount], 1))+1))+1) + 1, LEN([ledgeraccount]) - CHARINDEX('-', [ledgeraccount], (CHARINDEX('-', [ledgeraccount], 1))+1)) AS [ledgeraccountpt4]
,[postingtype]
,[generaljournalentry]
,[mainaccount]	-- Might not need if we can put this in gl_accounts
,[projid_sa]
,[text]	
,[originalaccountentry]
,[transactioncurrencycode]
,[transactioncurrencyamount]
,[accountingcurrencyamount]
,[reportingcurrencyamount]
,[createdtransactionid]
FROM generaljournalaccountentry
WHERE [IsDelete] IS NULL
),
select_generaljournalentry AS
(
SELECT 
	[accountingdate]
	,[documentdate]
	,[postinglayer]
	,[documentnumber]
	,[journalnumber]
	,[ledgerentryjournal]
	,[subledgervoucher]
	,[recid]
FROM generaljournalentry
WHERE [IsDelete] IS NULL
),


select_srsanalysisenums AS
(
SELECT
	[enumitemvalue]
	,[enumitemname]
FROM srsanalysisenums
WHERE enumname = 'LedgerPostingType' AND [IsDelete] IS NULL
),
select_transactionlog AS
(
SELECT 
	[createdtransactionid]
	,[txt]
FROM transactionlog
WHERE [IsDelete] IS NULL
)

SELECT 
	gje.[accountingdate]				AS	[accounting_date_key]
	,gje.[documentdate]					AS	[document_date_key]
	,CASE
		WHEN UPPER(SUBSTRING(gja.[ledgeraccount], CHARINDEX('-', gja.[ledgeraccount]) + 1, 2)) LIKE '[A-Z][A-Z]' THEN SUBSTRING(gja.[ledgeraccount], CHARINDEX('-', gja.[ledgeraccount]) + 1, 2)
		ELSE NULL
	END									AS	[branch_key]
	,CASE
		WHEN UPPER(SUBSTRING(gja.[ledgeraccount], CHARINDEX('-', gja.[ledgeraccount]) + 4, 4)) LIKE '[0-9][0-9][A-Z][A-Z]' THEN SUBSTRING(gja.[ledgeraccount], CHARINDEX('-', gja.[ledgeraccount]) + 4, 4)
		ELSE NULL
	END									AS	[department_key]
	,CASE
		WHEN UPPER(SUBSTRING(gja.[ledgeraccount], 1, 6)) LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]' THEN SUBSTRING(gja.[ledgeraccount], 1, 6)
		ELSE NULL
	END									AS 	[account_number_key]
	--,brn.[branch_code_name]				AS	[branch_code_name] -- Once Branches and Departments view is populated, need to check that these map correctly.
	--,dpt.[department_code_name]			AS	[department_code_name]
	,gje.[postinglayer]					AS	[posting_layer]
	,gja.[postingtype]					AS	[posting_type_code]
	,srs.[enumitemname]					AS	[posting_type]
	,gje.[documentnumber]				AS 	[document_number]
	,gje.[journalnumber]				AS	[journal_number]
	,gja.[generaljournalentry]			AS	[general_journal_entry]
	,gje.[ledgerentryjournal]			AS	[ledger_entry_journal]
	,gja.[mainaccount]					AS	[main_account]
	,CONCAT(gja.[ledgeraccountpt1], '-', gja.[ledgeraccountpt2], '-', gja.[ledgeraccountpt3]) 	AS	[derived_ledger_account_entry]
	,gja.[ledgeraccountpt1]				AS	[ledger_account_level_1]
	,CASE
        WHEN gja.[ledgeraccountpt2] IS NULL OR gja.[ledgeraccountpt2] = '' THEN 'BS'
        ELSE gja.[ledgeraccountpt2]
     END								AS [ledger_account_level_2]
    ,CASE
        WHEN gja.[ledgeraccountpt3] IS NULL THEN '101'
        ELSE gja.[ledgeraccountpt3] 
	 END								AS [ledger_account_level_3]
    ,CASE
        WHEN gja.[ledgeraccountpt4] IS NULL THEN 'N/A'
        ELSE gja.[ledgeraccountpt4]
     END								AS [ledger_account_level_4]
	,gja.[projid_sa]					AS	[project_id]
	,gje.[subledgervoucher]				AS	[reference_number]
	,gja.[text]							AS	[narration]	-- Possible rename
	,SUBSTRING(trn.[txt], 1, CHARINDEX(' ', trn.[txt]))	AS	[Journal Number]
	,CONCAT(SUBSTRING(trn.[txt], 1, CHARINDEX(' ', trn.[txt])), gje.[subledgervoucher])	AS	[Journal Voucher]
	,gja.[originalaccountentry]			AS	[original_account_entry]
	,gja.[transactioncurrencycode]		AS 	[transaction_currency_code]
	,gja.[transactioncurrencyamount]	AS	[transaction_currency_amount]
	,gja.[accountingcurrencyamount]		AS	[accounting_currency_amount]
	,gja.[reportingcurrencyamount]		AS	[reporting_currency_amount]
FROM select_generaljournalaccountentry gja
	INNER JOIN select_generaljournalentry gje ON gja.[generaljournalentry] = gje.[recid]
	INNER JOIN select_transactionlog trn ON gja.[createdtransactionid] = trn.[createdtransactionid]
	INNER JOIN select_srsanalysisenums srs ON gja.[postingtype] = srs.[enumitemvalue]
	--LEFT JOIN branches brn ON CASE WHEN UPPER(SUBSTRING(gja.[ledgeraccount], CHARINDEX('-', gja.[ledgeraccount]) + 1, 2)) LIKE '[A-Z][A-Z]' THEN SUBSTRING(gja.[ledgeraccount], CHARINDEX('-', gja.[ledgeraccount]) + 1, 2) ELSE NULL END = brn.[branch_key] -- Dependancy on Branches
	--LEFT JOIN departments dpt ON CASE WHEN UPPER(SUBSTRING(gja.[ledgeraccount], CHARINDEX('-', gja.[ledgeraccount]) + 4, 4)) LIKE '[0-9][0-9][A-Z][A-Z]' THEN SUBSTRING(gja.[ledgeraccount], CHARINDEX('-', gja.[ledgeraccount]) + 4, 4) ELSE NULL END = dpt.[department_key];
 -- Wait for Branches & Department view 

	
	


