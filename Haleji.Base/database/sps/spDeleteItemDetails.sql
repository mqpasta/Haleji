
IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spDeleteItemDetails'
)
	
	DROP PROCEDURE dbo.spDeleteItemDetails
GO

CREATE PROCEDURE dbo.spDeleteItemDetails
	@ItemId bigint

AS 
	DELETE FROM ItemDetails WHERE ItemId = @ItemId;

GO