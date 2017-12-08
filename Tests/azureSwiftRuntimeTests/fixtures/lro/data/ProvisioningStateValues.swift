// ProvisioningStateValues enumerates the values for provisioning state values.

public enum ProvisioningStateValues: String, Codable
{
// Accepted specifies the accepted state for provisioning state values.
    case Accepted = "Accepted"
// Canceled specifies the canceled state for provisioning state values.
    case Canceled = "canceled"
// Created specifies the created state for provisioning state values.
    case Created = "Created"
// Creating specifies the creating state for provisioning state values.
    case Creating = "Creating"
// Deleted specifies the deleted state for provisioning state values.
    case Deleted = "Deleted"
// Deleting specifies the deleting state for provisioning state values.
    case Deleting = "Deleting"
// Failed specifies the failed state for provisioning state values.
    case Failed = "Failed"
// OK specifies the ok state for provisioning state values.
    case OK = "OK"
// Succeeded specifies the succeeded state for provisioning state values.
    case Succeeded = "Succeeded"
// Updated specifies the updated state for provisioning state values.
    case Updated = "Updated"
// Updating specifies the updating state for provisioning state values.
    case Updating = "Updating"
}
