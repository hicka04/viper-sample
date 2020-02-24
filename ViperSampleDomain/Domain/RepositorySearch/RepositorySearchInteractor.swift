//
//  RepositorySearchInteractor.swift
//  ViperSampleDomain
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation
import ViperSampleData

public protocol RepositorySearchUsecase: AnyObject {
    
    func search(keyword: String,
                completion: @escaping (Result<[Repository], Error>) -> Void)
}

public final class RepositorySearchInteractor {
    
    private let gitHubDataStore: GitHubRepository
    private let translator: RepositorySearchTranslator
    
    public convenience init() {
        self.init(gitHubDataStore: GitHubDataStore(), translator: .init())
    }
    
    init(gitHubDataStore: GitHubRepository,
         translator: RepositorySearchTranslator) {
        self.gitHubDataStore = gitHubDataStore
        self.translator = translator
    }
}

extension RepositorySearchInteractor: RepositorySearchUsecase {
    
    public func search(keyword: String,
                       completion: @escaping (Result<[Repository], Error>) -> Void) {
        gitHubDataStore.searchRepositories(keyword: keyword) { result in
            switch result {
            case .success(let repositories):
                completion(.success(self.translator.translate(repositories)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
