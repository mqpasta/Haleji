-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertPurchaseDetails' 
)
   DROP PROCEDURE dbo.spInsertPurchaseDetails
GO

CREATE PROCEDURE dbo.spInsertPurchaseDetails
	 @PurchaseId bigint ,
	 @ItemDetailsId bigint ,
	 @Description nvarchar(500) = NULL
AS
	DECLARE @PurchaseDetailsId bigint

	BEGIN TRAN
	INSERT INTO		PurchaseDetails(
					PurchaseId,ItemDetailsId,Description)
					VALUES (@PurchaseId, @ItemDetailsId,@Description)
	SET @PurchaseDetailsId = SCOPE_IDENTITY()

	COMMIT
	
GO