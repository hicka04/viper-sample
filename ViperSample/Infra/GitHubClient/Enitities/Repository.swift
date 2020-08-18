//
//  Repository.swift
//  viper-sample
//
//  Created by hicka04 on 2018/07/26.
//  Copyright © 2018年 hicka04. All rights reserved.
//

import Foundation

struct Repository: Decodable {

    let id: Int
    let name: String
    let fullName: String
    let htmlURL: URL
    let starCount: Int
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case htmlURL = "html_url"
        case starCount = "stargazers_count"
        case owner
    }
}
