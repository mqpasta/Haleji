
IF EXISTS (
	SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spSelectItemDetail'
)

	DROP PROCEDURE dbo.spSelectItemDetail
GO

CREATE PROCEDURE dbo.spSelectItemDetail
	@ItemId bigint

AS
	SELECT * FROM ItemDetails WHERE ItemId = @ItemId

GO
