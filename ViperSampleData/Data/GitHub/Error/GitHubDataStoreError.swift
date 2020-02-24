//
//  GitHubDataStoreError.swift
//  ViperSampleData
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation

public enum GitHubDataStoreError: Error {
    
    case connectionError(Error)
    case responseParseError(Error)
    case apiError(GitHubAPIError)
}
