//
//  SearchResponse.swift
//  ViperSampleData
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation

public struct SearchResponse<Item: Codable>: Codable {
    
    public let totalCount: Int
    public let items: [Item]
}
