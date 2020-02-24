//
//  SearchRepositories.swift
//  ViperSampleData
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation

extension Endpoint.Search {
    
    struct SearchRepositories: GitHubRequest {
        
        typealias Response = SearchResponse<Repository>
        
        let path: String = "search/repositories"
        let method: HTTPMethod = .get
        var queryItems: [URLQueryItem] {
            [
                .init(name: "q", value: keyword)
            ]
        }
        
        let keyword: String
    }
}
