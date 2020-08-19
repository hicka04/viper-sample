//
//  RepositorySearchResultPresenter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

protocol RepositorySearchResultPresentation: AnyObject {
    
    func viewDidLoad()
    func searchButtonDidPush(searchText: String)
    func didSelectRow(at indexPath: IndexPath)
}

final class RepositorySearchResultPresenter {

    // View, Interactor, Routerへのアクセスはprotocolを介して行う
    // Viewは循環参照にならないよう`weak`プロパティ
    private weak var view: RepositorySearchResultView?
    private let router: RepositorySearchResultWireframe
    private let historyInteractor: SearchHistoryUsecase
    private let repositoryInteractor: SearchRepositoryUsecase
    
    private var searchText: String = "" {
        didSet {
            guard !searchText.isEmpty else { return }
            
            view?.setLastSearchText(searchText)
            
            // Interactorにデータ取得処理を依頼
            // `@escaping`がついているクロージャの場合は循環参照にならないよう`[weak self]`でキャプチャ
            repositoryInteractor.fetchRepositories(keyword: searchText) { [weak self] result in
                switch result {
                case .success(let repositories):
                    self?.repositories = repositories
                case .failure:
                    self?.repositories.removeAll()
                    self?.view?.showErrorAlert()
                }
            }
        }
    }
    
    private var repositories: [Repository] = [] {
        didSet {
            view?.updateRepositories(repositories)
        }
    }

    init(view: RepositorySearchResultView,
         router: RepositorySearchResultWireframe,
         historyInteractor: SearchHistoryUsecase,
         repositoryInteractor: SearchRepositoryUsecase) {
        self.view = view
        self.router = router
        self.historyInteractor = historyInteractor
        self.repositoryInteractor = repositoryInteractor
    }
}

// Presenterのプロトコルに準拠する
extension RepositorySearchResultPresenter: RepositorySearchResultPresentation {
    
    func viewDidLoad() {
        // Interactorにデータ取得処理を依頼
        historyInteractor.loadLastSeachText { result in
            switch result {
            case .success(let searchText):
                self.searchText = searchText
            case .failure:
                break
            }
        }
    }
    
    func searchButtonDidPush(searchText: String) {
        self.searchText = searchText
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < repositories.count else { return }
        
        let repository = repositories[indexPath.row]
        router.showRepositoryDetail(repository) // Routerに画面遷移を依頼
    }
}
