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
    weak var delegate: RepositoryListInteractorDelegate?
}

// Interactorのプロトコルに準拠する
extension RepositoryListInteractor: RepositoryListUsecase {

    // 時間がかかるパターン
    func fetchRepositories(keyword: String) {
        let request = GitHubAPI.SearchRepositories(keyword: keyword)
        
        let client = GitHubClient()
        client.send(request: request) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    // 取得完了したことを通知
                    self.delegate?.interactor(self, didFetchedRepositories: response.items)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.interactor(self, didFailedWithError: error)
                }
            }
        }
    }
}
