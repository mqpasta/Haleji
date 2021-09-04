-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllDepartment' 
)
   DROP PROCEDURE dbo.spGetAllDepartment
GO

CREATE PROCEDURE dbo.spGetAllDepartment
AS
	SELECT * FROM Department 
GO


