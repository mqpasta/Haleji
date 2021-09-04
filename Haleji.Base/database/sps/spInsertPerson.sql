-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertPerson' 
)
   DROP PROCEDURE dbo.spInsertPerson
GO

CREATE PROCEDURE dbo.spInsertPerson
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	Insert Into Person (DepartmentId, Name, Ext, Contact, IsActive)
		VALUES (@DepartmentId, @Name, @Ext, @Contact, @IsActive)

	SELECT SCOPE_IDENTITY()
GO


