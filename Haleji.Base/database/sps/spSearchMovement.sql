-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchMovement' 
)
   DROP PROCEDURE dbo.spSearchMovement
GO

CREATE PROCEDURE dbo.spSearchMovement
	@MovementId bigint = NULL,
	@TransTypeId bigint = NULL,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@StartDate date = NULL,
	@EndDate date = NULL,
	@IsActive bit = NULL,
	@ParentMovement bigint = NULL
AS
	;with cteItems(PurchaseId, ItemName) 
	AS (
		SElECT P.PurchaseId, I.ItemName + '(' + P.TagNo + ')' AS ItemName
		FROM Item I Inner Join Purchase P ON I.ItemId = P.ItemId
	)
	SELECT	M.*, I.ItemName, L.LocationName, P.Name
	FROM Movement M  Left Join cteItems I ON M.PurchaseId = I.PurchaseId
		LEFT JOIN Location L ON L.LocationId = M.LocationId
		Left Join Person P ON P.PersonId = M.PersonId		
	WHERE (@MovementId IS NULL OR MovementId = @MovementId)
		AND (@TransTypeId IS NULL OR TransTypeId = @TransTypeId)
		AND (@PersonId IS NULL OR M.PersonId = @PersonId)
		AND (@LocationId IS NULL OR M.LocationId = @LocationId)
		AND (@PurchaseId IS NULL OR M.PurchaseId = @PurchaseId)
		AND (@StartDate IS NULL OR MovDate >= @StartDate)
		AND (@EndDate IS NULL OR MovDate <= @EndDate)
		AND (@IsActive IS NULL OR M.IsActive = @IsActive)
		AND (@ParentMovement IS NULL OR ParentMovement = @ParentMovement)
	ORDER BY m.MovDate 

GO

