CREATE PROCEDURE usp_GetEmployeeLoginHistory
    @StartDate DATETIME2 = NULL,
    @EndDate DATETIME2 = NULL,
    @OnlyInactive BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.EmployeeId,
        e.FirstName,
        e.LastName,
        MAX(a.UpdatedOn) AS LastLoginDate
    FROM [Task].[Main].[Employee] e
    LEFT JOIN [Task].[Main].[ActivityLog] a
        ON e.EmployeeId = a.UpdatedBy
        AND a.ActivityType = 1
    WHERE
        (@StartDate IS NULL OR a.UpdatedOn >= @StartDate)
        AND (@EndDate IS NULL OR a.UpdatedOn <= @EndDate)
    GROUP BY e.EmployeeId, e.FirstName, e.LastName
    HAVING
        (@OnlyInactive = 0 OR MAX(a.UpdatedOn) IS NULL)
    ORDER BY LastLoginDate DESC;
END

EXEC usp_GetEmployeeLoginHistory NULL, NULL, 1;


