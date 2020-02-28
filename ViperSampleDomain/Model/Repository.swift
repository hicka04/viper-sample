//
//  Repository.swift
//  ViperSampleDomain
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation

public struct Repository: Decodable, Equatable {
    
    public let id: ID
    public let name: String
    public let fullName: String
}

extension Repository {
    
    public struct ID: RawRepresentable, Decodable, Equatable {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}
