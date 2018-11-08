CREATE PROCEDURE [dbo].[sp_restore_log_CDC_NO]
	-- Input parameters
	@FILENAME NVARCHAR(200)
AS
BEGIN
	SET NOCOUNT ON;
	-- Create the full filepath
	SELECT CONCAT(N'D:\SQLData\MSSQL13.MSSQLSERVER\MSSQL\Backup\', @FILENAME)
    
END
GO

EXEC [dbo].sp_restore_log_CDC_NO @FILENAME = N'logfile.txt'