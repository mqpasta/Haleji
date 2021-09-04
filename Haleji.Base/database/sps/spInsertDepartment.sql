-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertDepartment' 
)
   DROP PROCEDURE dbo.spInsertDepartment
GO

CREATE PROCEDURE dbo.spInsertDepartment
	@DepartmentName nvarchar(200)
AS
	Insert Into Department (DepartmentName) VALUES(@DepartmentName)
	SELECT SCOPE_IDENTITY()
GO


