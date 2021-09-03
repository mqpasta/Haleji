-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertLocation' 
)
   DROP PROCEDURE dbo.spInsertLocation
GO

CREATE PROCEDURE dbo.spInsertLocation
	@LocationName nvarchar(200)
AS
	INSERT INTO Location (LocationName) VALUES(@LocationName)
	SELECT SCOPE_IDENTITY()
GO

