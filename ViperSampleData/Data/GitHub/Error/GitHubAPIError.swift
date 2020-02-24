//
//  GitHubAPIError.swift
//  ViperSampleData
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation

public struct GitHubAPIError: Error, Codable {
    
    public let message: String
}
