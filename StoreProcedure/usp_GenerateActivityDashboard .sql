CREATE PROCEDURE usp_GenerateActivityDashboard
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.EmployeeId,
        e.FirstName,
        e.LastName,
        a.ActivityType,
        COUNT(a.Id) AS TotalActivities,
        MAX(a.UpdatedOn) AS LastActivityDate
    FROM [Task].[Main].[Employee] e
    LEFT JOIN [Task].[Main].[ActivityLog] a
        ON e.EmployeeId = a.UpdatedBy
    GROUP BY
        e.EmployeeId,
        e.FirstName,
        e.LastName,
        a.ActivityType
    ORDER BY e.EmployeeId;
END

EXEC usp_GenerateActivityDashboard;
