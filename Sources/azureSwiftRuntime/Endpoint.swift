//
//  Endpoint.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/12/17.
//

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
