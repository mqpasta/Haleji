-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateDepartment' 
)
   DROP PROCEDURE dbo.spUpdateDepartment
GO

CREATE PROCEDURE dbo.spUpdateDepartment
	@DepartmentId bigint,
	@DepartmentName nvarchar(200)
AS
	UPDATE Department SET DepartmentName = @DepartmentName 
	WHERE	DepartmentId = @DepartmentId
GO


