ALTER PROCEDURE usp_GetWorkflowParticipant
    @WorkflowId INT
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH CleanParticipants AS (
        SELECT
            *,
            TRY_CONVERT(BIGINT, UserId) AS UserIdBigInt
        FROM [Task].[Workflow].[Participant]
        WHERE WorkflowId = @WorkflowId
    )
    SELECT
        p.[Order] AS ParticipantOrder,
        e.EmployeeId,
        CONCAT(e.FirstName, ' ', e.LastName) AS Name,
        e.Email
    FROM CleanParticipants p
    INNER JOIN [Task].[Main].[Employee] e
        ON p.UserIdBigInt = e.EmployeeId
    WHERE p.UserIdBigInt IS NOT NULL
    ORDER BY p.[Order];
END
EXEC usp_GetWorkflowParticipant 3;
