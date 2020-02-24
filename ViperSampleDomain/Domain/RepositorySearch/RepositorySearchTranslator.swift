//
//  RepositorySearchTranslator.swift
//  ViperSampleDomain
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation
import ViperSampleData

struct RepositorySearchTranslator: Translator {
    
    typealias Input = [ViperSampleData.Repository]
    typealias Output = [Repository]
}
