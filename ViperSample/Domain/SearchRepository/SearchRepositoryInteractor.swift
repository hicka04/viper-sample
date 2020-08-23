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
                           completion: @escaping (Result<[RepositoryEntity], Error>) -> Void)
}

final class SearchRepositoryInteractor {
    
    // GitHubに問い合わせるためのAPIクライアント
    // Interactorのテスト時にAPIクライアントをMockに差し替えて任意のレスポンスを返すようにするため
    private let client: GitHubRequestable
    
    init(client: GitHubRequestable = GitHubClient()) {
        self.client = client
    }
}

// Interactorのプロトコルに準拠する
extension SearchRepositoryInteractor: SearchRepositoryUsecase {
    
    func fetchRepositories(keyword: String,
                           completion: @escaping (Result<[RepositoryEntity], Error>) -> Void) {
        let request = GitHubAPI.SearchRepositories(keyword: keyword)
        client.send(request: request) { result in
            completion(result.map { $0.items })
        }
    }
}
