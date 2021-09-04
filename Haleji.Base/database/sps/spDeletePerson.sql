-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeletePerson' 
)
   DROP PROCEDURE dbo.spDeletePerson
GO

CREATE PROCEDURE dbo.spDeletePerson
	@PersonId bigint
AS
	DELETE FROM Person WHERE PersonId = @PersonId
GO

