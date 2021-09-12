-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertMovement' 
)
   DROP PROCEDURE dbo.spInsertMovement
GO

CREATE PROCEDURE dbo.spInsertMovement
	@TransTypeId bigint ,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@MovDate date ,
	@IsActive bit ,
	@ParentMovement bigint = NULL
AS

	INSERT INTO Movement (TransTypeId, PersonId, LocationId, PurchaseId,
					MovDate, IsActive, ParentMovement)
		VALUES (@TransTypeId, @PersonId, @LocationId, @PurchaseId,
				@MovDate, @IsActive, @ParentMovement)

GO

