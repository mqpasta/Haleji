-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateLocation' 
)
   DROP PROCEDURE dbo.spUpdateLocation
GO

CREATE PROCEDURE dbo.spUpdateLocation
	@LocationId bigint, 
	@LocationName nvarchar(200)
AS
	UPDATE Location
	SET LocationName = @LocationName
	WHERE LocationId = @LocationId
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
--EXECUTE dbo.spUpdateLocation 1, 2
--GO
