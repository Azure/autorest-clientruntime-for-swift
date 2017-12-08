// Status enumerates the values for status.

public enum Status: String, Codable
{
// StatusAccepted specifies the status accepted state for status.
    case StatusAccepted = "Accepted"
// StatusCanceled specifies the status canceled state for status.
    case StatusCanceled = "canceled"
// StatusCreated specifies the status created state for status.
    case StatusCreated = "Created"
// StatusCreating specifies the status creating state for status.
    case StatusCreating = "Creating"
// StatusDeleted specifies the status deleted state for status.
    case StatusDeleted = "Deleted"
// StatusDeleting specifies the status deleting state for status.
    case StatusDeleting = "Deleting"
// StatusFailed specifies the status failed state for status.
    case StatusFailed = "Failed"
// StatusOK specifies the status ok state for status.
    case StatusOK = "OK"
// StatusSucceeded specifies the status succeeded state for status.
    case StatusSucceeded = "Succeeded"
// StatusUpdated specifies the status updated state for status.
    case StatusUpdated = "Updated"
// StatusUpdating specifies the status updating state for status.
    case StatusUpdating = "Updating"
}
