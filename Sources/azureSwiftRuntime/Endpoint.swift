/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

public enum Endpoint: String {
    case portal                         = "portalUrl"
    case management                     = "managementEndpointUrl"
    case resourceManager                = "resourceManagerEndpointUrl"
    case activeDirectory                = "activeDirectoryEndpointUrl"
    case graph                          = "activeDirectoryGraphResourceId"
    case keyVault                       = "keyVaultDnsSuffix"
    case storage                        = "storageEndpointSuffix"
    case dataLakeStore                  = "azureDataLakeStoreFileSystemEndpointSuffix"
    case dataLakeAnalystic              = "azureDataLakeAnalyticsCatalogAndJobEndpointSuffix"
    case gallery                        = "galleryEndpointUrl"
    case sql                            = "sqlManagementEndpointUrl"
    case dataLake                       = "dataLakeEndpointResourceId"
    case publishingProfile              = "publishingProfileUrl"
    case sqlServerHostnameSuffix        = "sqlServerHostnameSuffix"
    case activeDirectoryResourceId      = "activeDirectoryResourceId"
    case activeDirectoryGraphApiVersion = "activeDirectoryGraphApiVersion"
}
