CREATE PROCEDURE usp_GetActivitysReport
    @StartDate DATETIME2,
    @EndDate DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ActivityType,
        Description AS Action,
        COUNT(*) AS ActivityCount
    FROM [Task].[Main].[ActivityLog]
    WHERE UpdatedOn BETWEEN @StartDate AND @EndDate
    GROUP BY ActivityType, Description
    ORDER BY ActivityType;
END

EXEC usp_GetActivitysReport 
    '2025-03-19', 
    '2025-03-31';
