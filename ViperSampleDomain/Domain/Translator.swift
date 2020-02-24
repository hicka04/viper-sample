//
//  Translator.swift
//  ViperSampleDomain
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation

protocol Translator {
    
    associatedtype Input
    associatedtype Output
    
    func translate(_ input: Input) -> Output
}

extension Translator where Input: Codable, Output: Decodable {
    
    func translate(_ input: Input) -> Output {
        let data = try! JSONEncoder().encode(input)
        return try! JSONDecoder().decode(Output.self, from: data)
    }
}
