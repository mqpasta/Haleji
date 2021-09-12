-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeletePurchase' 
)
   DROP PROCEDURE dbo.spDeletePurchase
GO

CREATE PROCEDURE dbo.spDeletePurchase
	 @PurchaseId bigint,
	 @TransTypeId bigint
AS
	IF NOT EXISTS(SELECT 1 FROM Movement WHERE PurchaseId = @PurchaseId and TransTypeId <> @TransTypeId)
	BEGIN
		BEGIN TRAN
		DELETE FROM Movement WHERE PurchaseId = @PurchaseId and TransTypeId = @TransTypeId
		DELETE FROM Purchase WHERE PurchaseId = @PurchaseId
		COMMIT
	END
	ELSE
	BEGIN
		RAISERROR('The purchase cannot be deleted as item arleady issued.',16,1)
	END
	
GO

