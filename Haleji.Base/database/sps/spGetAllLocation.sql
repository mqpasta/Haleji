-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllLocation' 
)
   DROP PROCEDURE dbo.spGetAllLocation
GO

CREATE PROCEDURE dbo.spGetAllLocation
AS
	SELECT * FROM Location
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
--EXECUTE dbo.spGetAllLocation 
--GO
