-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spMovementLedger' 
)
   DROP PROCEDURE dbo.spMovementLedger
GO

CREATE PROCEDURE dbo.spMovementLedger
	@TransTypeId bigint = NULL,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@DepartmentId bigint = NULL,
	@PurchaseId bigint = NULL,
	@ItemId bigint = NULL,
	@StartDate date = NULL,
	@EndDate date = NULL
AS
	select  M.MovementId, M.MovDate, M.TransTypeId, T.TransTypeName,
		P.TagNo, I.ItemName,
		CASE WHEN PE.Name IS NULL THEN '' ELSE PE.Name END AS [Name],  
		CASE WHEN D.DepartmentName IS NULL THEN '' ELSE D.DepartmentName END AS DepartmentName, 
		CASE WHEN L.LocationName IS NULL THEN '' ELSE L.LocationName END AS LocationName
	from Movement M 
		Left Join Person PE ON PE.PersonId = M.PersonId
		Left Join Location L ON L.LocationId = M.LocationId
		Inner Join Purchase P ON P.PurchaseId = M.PurchaseId
		Inner Join Item I ON I.ItemId = P.ItemId
		Left Join Department D ON PE.DepartmentId = D.DepartmentId
		Inner Join TransType T ON T.TransTypeId = M.TransTypeId			
	WHERE 1 = 1
		AND (@TransTypeId IS NULL OR M.TransTypeId = @TransTypeId)
		AND (@PersonId IS NULL OR M.PersonId = @PersonId)
		AND (@LocationId IS NULL OR M.LocationId = @LocationId)
		AND (@PurchaseId IS NULL OR M.PurchaseId = @PurchaseId)
		AND (@ItemId IS NULL OR I.ItemId = @ItemId)
		AND (@DepartmentId IS NULL OR D.DepartmentId = @DepartmentId)
		AND (@StartDate IS NULL OR MovDate >= @StartDate)
		AND (@EndDate IS NULL OR MovDate <= @EndDate)
	ORDER BY m.MovDate 

GO

