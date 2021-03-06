/**************************************************************************
** CREATED BY:   Bulent Gucuk
** CREATED DATE: 2019.02.26
** CREATED FOR:  Enabling the jobs after maintenance
** NOTES:	The script depends on the DBA database and table named dbo.JobsRunning
**			When executed it will enable all the jobs which were disabled
**			before the maintenance
***************************************************************************/
USE msdb; 
GO
DECLARE @RowId SMALLINT = 1
	, @MaxRowId SMALLINT
	, @job_name SYSNAME
	, @enablejob TINYINT = 1;  -- 0 = disable job 1 = Enable job

SELECT @MaxRowId = RowId
FROM	DBA.DBO.JobsEnabled;

WHILE @RowId <= @MaxRowId
	BEGIN
		SELECT	@job_name = name
		FROM	DBA.dbo.JobsEnabled
		WHERE	RowId = @RowId;

		EXEC msdb.dbo.sp_update_job
			@job_name = @job_name,
			@enabled = @enablejob;

		SELECT @RowId = @RowId + 1;
	END
