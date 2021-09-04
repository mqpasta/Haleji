-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteDepartment' 
)
   DROP PROCEDURE dbo.spDeleteDepartment
GO

CREATE PROCEDURE dbo.spDeleteDepartment
	@DepartmentId bigint
AS
	DELETE FROM Department 
	WHERE	DepartmentId = @DepartmentId
GO


