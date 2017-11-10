//
//  Environment.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/1/17.
//

import Foundation

public enum Endpoint: String {
    case portal             = "portalUrl"
    case management         = "managementEndpointUrl"
    case resourceManager    = "resourceManagerEndpointUrl"
    case activeDirectory    = "activeDirectoryEndpointUrl"
    case graph              = "activeDirectoryGraphResourceId"
    case keyVault           = "keyVaultDnsSuffix"
    case storage            = "storageEndpointSuffix"
    case dataLakeStore      = "azureDataLakeStoreFileSystemEndpointSuffix"
    case dataLakeAnalystic  = "azureDataLakeAnalyticsCatalogAndJobEndpointSuffix"
    case gallery            = "galleryEndpointUrl"
    case sql                = "sqlManagementEndpointUrl"
    case dataLake           = "dataLakeEndpointResourceId"
    case publishingProfile  = "publishingProfileUrl"
    case sqlServerHostnameSuffix        = "sqlServerHostnameSuffix"
    case activeDirectoryResourceId      = "activeDirectoryResourceId"
    case activeDirectoryGraphApiVersion = "activeDirectoryGraphApiVersion"
}

public protocol Environment {
    var endpoints : Dictionary<Endpoint, String> { get }
    func url(forEndpoint: Endpoint) -> String
}

public class AuzureEnvironment : Environment {
    public let endpoints : Dictionary<Endpoint, String>

    init(endpoints : Dictionary<Endpoint, String>) {
        self.endpoints = endpoints
    }
    
    public func url(forEndpoint: Endpoint) -> String {
        return self.endpoints[forEndpoint]!
    }
    
    static let azure = AuzureEnvironment(endpoints: [
        .management             : "https://management.core.windows.net",
        .resourceManager        : "https://management.azure.com/",
        .graph                  : "https://graph.windows.net/",
        .activeDirectory        : "https://login.microsoftonline.com/",
        .keyVault               : ".vault.azure.net",
        .storage                : ".core.windows.net",
        .dataLakeStore          : "azuredatalakestore.net",
        .dataLakeAnalystic      : "azuredatalakeanalytics.net",
        .gallery                : "https://gallery.azure.com/",
        .sql                    : "https://management.core.windows.net:8443/",
        .dataLake               : "https://datalake.azure.net/",
        .portal                 : "http://go.microsoft.com/fwlink/?LinkId=254433",
        .publishingProfile      : "http://go.microsoft.com/fwlink/?LinkId=254432",
        .sqlServerHostnameSuffix        : ".database.windows.net",
        .activeDirectoryResourceId      : "https://management.core.windows.net/",
        .activeDirectoryGraphApiVersion : "2013-04-05",
    ])
}


