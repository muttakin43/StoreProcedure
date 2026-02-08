CREATE PROCEDURE usp_GetEmployeesSummary
    @AccountId BIGINT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        COUNT(*) AS TotalEmployees,
        SUM(CASE WHEN Archived = 0 THEN 1 ELSE 0 END) AS ActiveEmployees,
        SUM(CASE WHEN Archived = 1 THEN 1 ELSE 0 END) AS ArchivedEmployees
    FROM [Task].[Main].[Employee]
    WHERE
        (@AccountId IS NULL OR AccountId = @AccountId);
END


EXEC usp_GetEmployeesSummary ;
