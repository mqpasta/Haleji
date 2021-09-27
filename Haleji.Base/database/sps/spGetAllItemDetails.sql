IF EXISTS(
	SELECT * 
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spGetAllItemDetails'
)
	DROP PROCEDURE dbo.spGetAllItemDetails
GO

CREATE PROCEDURE dbo.spGetAllItemDetails
AS
	SELECT ID.*,I.ItemName
	FROM ItemDetails ID inner join Item I on ID.ItemId = I.ItemId

GO