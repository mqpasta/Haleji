-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllPerson' 
)
   DROP PROCEDURE dbo.spGetAllPerson
GO

CREATE PROCEDURE dbo.spGetAllPerson
AS
	SELECT P.* , D.DepartmentName
	FROM Person P LEFT JOIN Department D ON P.DepartmentId = D.DepartmentId
GO


