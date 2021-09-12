-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchDepartment' 
)
   DROP PROCEDURE dbo.spSearchDepartment
GO

CREATE PROCEDURE dbo.spSearchDepartment
	@DepartmentId bigint = NULL,
	@DepartmentName nvarchar(200) = NULL
AS
	SELECT * FROM Department 
	WHERE (@DepartmentId IS NULL OR DepartmentId = @DepartmentId)
	AND (@DepartmentName IS NULL OR DepartmentName LIKE '%'+@DepartmentName+'%')

GO


