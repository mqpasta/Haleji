-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spEditPerson' 
)
   DROP PROCEDURE dbo.spEditPerson
GO

CREATE PROCEDURE dbo.spEditPerson
	@PersonId bigint,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	UPDATE Person 
	SET		DepartmentId = @DepartmentId,
			Name  = @Name,
			Ext = @Ext,
			Contact = @Contact,
			IsActive = @IsActive
	WHERE	PersonId = @PersonId
GO


