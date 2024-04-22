-- =====================================================================================
-- account_manager
--
-- Purpose: Stores all Account Manager details for DS1 - Account Manager Budget Dataset
-- Created By: AB (20240422)

-- Modified By:
-- YYYYMMDD (XX): Added columns XXX for DSX - XXX Dataset.

-- =====================================================================================


WITH hcmposition_cte AS (
	SELECT
		[recid] AS [hcmposition_recid], -- RC
		[positionid], -- RC
		[ctr_site] -- RC
	FROM hcmposition
	WHERE [IsDelete] IS NULL
),
hcmpositiondetail_cte AS (
	SELECT
		[recid] AS [hcmpositiondetail_recid], -- RC
		[description],	-- RC
		[job],
		[position]
	FROM hcmpositiondetail
	WHERE [IsDelete] IS NULL
),
hcmpositionworkerassignment_cte AS (
	SELECT 
		[recid] AS [hcmpositionworker_recid], -- RC
		[position],
		[worker]
	FROM hcmpositionworkerassignment
	WHERE [IsDelete] IS NULL
),
hcmworker_cte AS (
	SELECT 
		[recid] AS [hcmworker_recid], -- RC
		[person],
		[personnelnumber], -- RC
		[ctr_empcusrelid] -- RC
	FROM hcmworker
	WHERE [IsDelete] IS NULL
)

SELECT 
	hwx.[personnelnumber] AS [personnel_number],
	dpt.[name] AS [account_manager_name],
	hwx.[ctr_empcusrelid] AS [account_manager_email_address],
	hpx.[ctr_site] AS [account_manager_branch_code],
	NULL AS [branch_name],
	NULL AS [_created_date],
	NULL AS [_updated_date],
	NULL AS [_deleted_date]
FROM hcmworker_cte hwx -- some account manager records do not have a name/email associated to them on the hcmworker table, however names available from dirpartytable.
	LEFT JOIN hcmpositionworkerassignment_cte hpwa ON hwx.hcmworker_recid = hpwa.worker 
	LEFT JOIN hcmposition_cte hpx ON hpwa.position = hpx.hcmposition_recid
	LEFT JOIN hcmpositiondetail_cte hpd ON hpx.hcmposition_recid = hpd.position
	LEFT JOIN dirpartytable dpt ON hwx.[person] = dpt.[recid]
	--LEFT JOIN branches b ON hpx.ctr_site = b.branch_code 
WHERE hpd.[description] = 'Account Manager' and dpt.[IsDelete] IS NULL
;




