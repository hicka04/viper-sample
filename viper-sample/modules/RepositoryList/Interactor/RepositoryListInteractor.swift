//
//  RepositoryListInteractor.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

class RepositoryListInteractor {

    // 取得処理が完了したことを通知はprotocolを介して行う
    weak var output: RepositoryListInteractorOutput?

    private var repositories: [Repository] = []
}

// Interactorのプロトコルに準拠する
extension RepositoryListInteractor: RepositoryListUsecase {
    
    // そのままデータを返すパターン
    var numberOfRepositories: Int {
        return repositories.count
    }
    
    func repository(at indexPath: IndexPath) -> Repository {
        return repositories[indexPath.row]
    }

    // 時間がかかるパターン
    func fetchRepositories(keyword: String) {
        let request = GitHubAPI.SearchRepositories(keyword: keyword)
        
        let client = GitHubClient()
        client.send(request: request) { result in
            switch result {
            case .success(let response):
                self.repositories += response.items
                DispatchQueue.main.async {
                    // 取得完了したことを通知
                    self.output?.fetchRepositoriesDidFinish()
                }
            case .failure:
                break
            }
        }
    }
}
