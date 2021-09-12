-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateMovement' 
)
   DROP PROCEDURE dbo.spUpdateMovement
GO

CREATE PROCEDURE dbo.spUpdateMovement
	@MovementId bigint,
	@TransTypeId bigint ,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@MovDate date ,
	@IsActive bit ,
	@ParentMovement bigint = NULL
AS
	UPDATE [dbo].[Movement]
	   SET [TransTypeId] = @TransTypeId
		  ,[PersonId] = @PersonId
		  ,[LocationId] = @LocationId
		  ,[PurchaseId] = @PurchaseId
		  ,[MovDate] = @MovDate
		  ,[IsActive] = @IsActive
		  ,[ParentMovement] = @ParentMovement
	 WHERE MovementId = @MovementId

GO

