-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchPerson' 
)
   DROP PROCEDURE dbo.spSearchPerson
GO

CREATE PROCEDURE dbo.spSearchPerson
	@PersonId bigint = NULL,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200) = NULL,
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = NULL
AS
	SELECT	P.*, D.DepartmentName
	FROM	Person P Left JOIN Department D ON P.DepartmentId = D.DepartmentId
	WHERE	(@PersonId IS NULL OR PersonId=@PersonId)
		AND	(@DepartmentId IS NULL OR P.DepartmentId = @DepartmentId)
		AND (@Name IS NULL OR Name LIKE '%'+@Name+'%')
		AND (@Ext IS NULL OR Ext LIKE '%'+@Ext+'%')
		AND (@Contact IS NULL OR Contact LIKE '%'+@Contact+'%')
		AND (@IsActive IS NULL OR IsActive = @IsActive)
GO


