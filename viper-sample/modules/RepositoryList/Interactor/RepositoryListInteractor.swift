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
    
    func loadLastSearchText() {
        let sortDescriptor = NSSortDescriptor(key: "lastSearchAt", ascending: false)
        guard let results = SearchHistory.select(orderBy: [sortDescriptor], limit: 1),
            !results.isEmpty,
            let searchText = results[0].searchText else {
            delegate?.interactor(self, lastSearchTextLoadState: .error)
            return
        }
        
        delegate?.interactor(self, lastSearchTextLoadState: .result(searchText: searchText))
    }

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
        
        SearchHistory.insert { entity in
            entity.searchText = keyword
            entity.firstSearchAt = Date()
            entity.lastSearchAt = Date()
        }
    }
}
