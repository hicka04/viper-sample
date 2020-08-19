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
    func didSelectRow(at indexPath: IndexPath)
}

final class RepositorySearchResultPresenter {
    // View, Interactor, Routerへのアクセスはprotocolを介して行う
    // Viewは循環参照にならないよう`weak`プロパティ
    private weak var view: RepositorySearchResultView?
    private let router: RepositorySearchResultWireframe
    private let searchRepositoryInteractor: SearchRepositoryUsecase
    
    private var repositories: [Repository] = [] {
        didSet {
            view?.updateRepositories(repositories)
        }
    }

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
                self?.repositories = repositories
            case .failure:
                self?.repositories.removeAll()
                self?.view?.showErrorAlert()
            }
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < repositories.count else { return }
        
        let repository = repositories[indexPath.row]
        router.showRepositoryDetail(repository) // Routerに画面遷移を依頼
    }
}
