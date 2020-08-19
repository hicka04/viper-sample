//
//  RepositorySearchResultPresenter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

protocol RepositorySearchResultPresentation: AnyObject {
    func searchButtonDidPush(searchText: String)
    func didSelect(repository: Repository)
}

final class RepositorySearchResultPresenter {
    // View, Interactor, Routerへのアクセスはprotocolを介して行う
    // Viewは循環参照にならないよう`weak`プロパティ
    private weak var view: RepositorySearchResultView?
    private let router: RepositorySearchResultWireframe
    private let searchRepositoryInteractor: SearchRepositoryUsecase

    init(view: RepositorySearchResultView,
         router: RepositorySearchResultWireframe,
         searchRepositoryInteractor: SearchRepositoryUsecase) {
        self.view = view
        self.router = router
        self.searchRepositoryInteractor = searchRepositoryInteractor
    }
}

// Presenterのプロトコルに準拠する
extension RepositorySearchResultPresenter: RepositorySearchResultPresentation {
    func searchButtonDidPush(searchText: String) {
        guard !searchText.isEmpty else { return }
        // Interactorにデータ取得処理を依頼
        // `@escaping`がついているクロージャの場合は循環参照にならないよう`[weak self]`でキャプチャ
        searchRepositoryInteractor.fetchRepositories(keyword: searchText) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.view?.updateRepositories(repositories)
            case .failure:
                self?.view?.showErrorAlert()
            }
        }
    }
    
    func didSelect(repository: Repository) {
        router.showRepositoryDetail(repository)
    }
}
