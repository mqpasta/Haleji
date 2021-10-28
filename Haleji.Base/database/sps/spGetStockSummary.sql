-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetStockSummary' 
)
   DROP PROCEDURE dbo.spGetStockSummary
GO

CREATE PROCEDURE dbo.spGetStockSummary
AS
	

;with cte_avilable AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 1 
	GROUP BY I.ItemId, P.CurrentTransType
), cte_Issued AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 2
	GROUP BY I.ItemId, P.CurrentTransType
), cte_scrap AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 3
	GROUP BY I.ItemId, P.CurrentTransType
), cte_OutOfStock AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 4
	GROUP BY I.ItemId, P.CurrentTransType
)
select	Item.*,
		ISNULL(A.QTY,0) as AvailableQty,
		ISNULL(I.QTY,0) as IssuedQty,
		ISNULL(O.QTY,0) as OutQty,
		ISNULL(S.QTY,0) as ScrappedQty
from	Item 
			LEFT JOIN cte_avilable A ON A.ItemId = Item.ItemId
			LEFT JOIN cte_Issued I ON I.ItemId = Item.ItemId
			LEFT JOIN cte_OutOfStock O ON O.ItemId = Item.ItemId
			LEFT JOIN cte_scrap S ON S.ItemId = Item.ItemId

GO
