//
//  SearchRepositoryInteractor.swift
//  viper-sample
//
//  Created by hicka04 on 2019/07/17.
//  Copyright © 2019 hicka04. All rights reserved.
//

import Foundation

protocol SearchRepositoryUsecase: AnyObject {
    
    func fetchRepositories(keyword: String,
                           completion: @escaping (Result<[Repository], Error>) -> Void)
}

final class SearchRepositoryInteractor {
    
    private let client: GitHubRequestable
    
    init(client: GitHubRequestable = GitHubClient()) {
        self.client = client
    }
}

extension SearchRepositoryInteractor: SearchRepositoryUsecase {
    
    func fetchRepositories(keyword: String,
                           completion: @escaping (Result<[Repository], Error>) -> Void) {
        let request = GitHubAPI.SearchRepositories(keyword: keyword)
        client.send(request: request) { result in
            completion(result.map { $0.items })
        }
    }
}
