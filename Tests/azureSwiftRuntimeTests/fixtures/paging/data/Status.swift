// Status enumerates the values for status.

public enum Status: String, Codable
{
// Accepted specifies the accepted state for status.
    case Accepted = "Accepted"
// Canceled specifies the canceled state for status.
    case Canceled = "canceled"
// Created specifies the created state for status.
    case Created = "Created"
// Creating specifies the creating state for status.
    case Creating = "Creating"
// Deleted specifies the deleted state for status.
    case Deleted = "Deleted"
// Deleting specifies the deleting state for status.
    case Deleting = "Deleting"
// Failed specifies the failed state for status.
    case Failed = "Failed"
// OK specifies the ok state for status.
    case OK = "OK"
// Succeeded specifies the succeeded state for status.
    case Succeeded = "Succeeded"
// Updated specifies the updated state for status.
    case Updated = "Updated"
// Updating specifies the updating state for status.
    case Updating = "Updating"
}
