/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

public protocol Environment {
    var endpoints : Dictionary<Endpoint, String> { get }
    func url(forEndpoint: Endpoint) -> String?
}

public class AuzureEnvironment : Environment {
    public let endpoints : Dictionary<Endpoint, String>

    public init(endpoints : Dictionary<Endpoint, String>) {
        self.endpoints = endpoints
    }
    
    public func url(forEndpoint: Endpoint) -> String? {
        return self.endpoints[forEndpoint]
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


