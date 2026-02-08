CREATE PROCEDURE usp_SearchContact
    @SearchText NVARCHAR(100),
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
   
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    
    SELECT *
    FROM [Task].[Main].[Contact]
    WHERE Name LIKE '%' + @SearchText + '%'
       OR Email LIKE '%' + @SearchText + '%'
    ORDER BY Name
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;

    
    SELECT COUNT(*) AS TotalCount
    FROM [Task].[Main].[Contact]
    WHERE Name LIKE '%' + @SearchText + '%'
       OR Email LIKE '%' + @SearchText + '%';
END



EXEC usp_SearchContact
    @SearchText = 'john',
    @PageNumber = 1,
    @PageSize = 10;
