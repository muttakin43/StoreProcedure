CREATE PROCEDURE usp_GetEmployeeActivityLog
    @EmployeeId INT = NULL,
    @FromDate DATETIME = NULL,
    @ToDate DATETIME = NULL,
    @MaxRows INT = 100

AS
BEGIN
 SET NOCOUNT ON;

   IF @MaxRows IS NULL OR @MaxRows <= 0
        SET @MaxRows = 100;

    SELECT TOP (@MaxRows)
        Id,
        ActivityType,
        EntityId,
        Description,
        UpdatedBy,
        UpdatedOn,
        IP,
        Action
    FROM [Task].[Main].[ActivityLog]
    WHERE
        (@EmployeeId IS NULL OR UpdatedBy = @EmployeeId)
        AND (@FromDate IS NULL OR UpdatedOn >= @FromDate)
        AND (@ToDate IS NULL OR UpdatedOn <= @ToDate)
    ORDER BY UpdatedOn DESC;
END


EXEC usp_GetEmployeeActivityLog 
    @EmployeeId = 105, 
    @FromDate = '2025-01-01', 
    @ToDate = '2025-01-31', 
    @MaxRows = 50;