-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdatePurchase' 
)
   DROP PROCEDURE dbo.spUpdatePurchase
GO

CREATE PROCEDURE dbo.spUpdatePurchase
	 @PurchaseId bigint,
	 @ItemId bigint ,
	 @VendorId bigint ,
	 @PurchaseDate date ,
	 @StartDate date = NULL,
	 @EndDate date = NULL,
	 @PONumber nvarchar(50) = NULL,
	 @InvoiceNumber nvarchar(50) = NULL,
	 @Description nvarchar(500) = NULL,
	 @TagNo nvarchar(50), 
	 @TransTypeId bigint
AS

	BEGIN TRAN

	UPDATE	Purchase
	SET		ItemId = @ItemId, 
			VendorId = @VendorId, 
			PurchaseDate = @PurchaseDate, 
			StartDate = @StartDate, 
			EndDate= @EndDate,
			PONumber = @PONumber, 
			InvoiceNumber = @InvoiceNumber, 
			Description = @Description, 
			TagNo = @TagNo
	WHERE	PurchaseId = @PurchaseId

	UPDATE	Movement
	SET		MovDate = @PurchaseDate
	WHERE	PurchaseId = @PurchaseId

	COMMIT
					
GO

