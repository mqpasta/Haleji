-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchLocation' 
)
   DROP PROCEDURE dbo.spSearchLocation
GO

CREATE PROCEDURE dbo.spSearchLocation
	@LocationId bigint  = NULL, 
	@LocationName nvarchar(200) = NULL
AS
	SELECT	* 
	FROM	Location
	WHERE (@LocationId IS NULL OR LocationId = @LocationId) 
	AND (@LocationName IS NULL OR LocationName = @LocationName)
GO

