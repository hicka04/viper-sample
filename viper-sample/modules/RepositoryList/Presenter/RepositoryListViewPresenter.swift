//
//  RepositoryListPresenter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

protocol RepositoryListViewPresentation: AnyObject {
    
    func viewDidLoad()
    func searchButtonDidPush(searchText: String)
    func refreshControlValueChanged(searchText: String)
    func didSelectRow(at indexPath: IndexPath)
}

enum RepositoryListCellType {
    
    case repositoryCell(repository: Repository)
    case errorCell(error: Error)
    case noHistoryCell
}

final class RepositoryListViewPresenter {

    // View, Interactor, Routerへのアクセスはprotocolを介して行う
    private weak var view: RepositoryListView?
    private let router: RepositoryListWireframe
    private let historyInteractor: SearchHistoryUsecase
    private let repositoryInteractor: SearchRepositoryUsecase
    private var searchText: String = "" {
        didSet {
            guard !searchText.isEmpty else { return }
            
            view?.setLastSearchText(searchText)
            view?.showRefreshView()
            repositoryInteractor.fetchRepositories(keyword: searchText) { result in
                switch result {
                case .success(let repositories):
                    self.repositories = repositories
                case .failure:
                    self.repositories.removeAll()
                    self.view?.showErrorMessageView(reason: "エラーが発生しました")
                }
            }
        }
    }
    
    private var repositories: [Repository] = [] {
        didSet {
            view?.updateRepositories(repositories)
        }
    }

    init(view: RepositoryListView,
         router: RepositoryListWireframe,
         historyInteractor: SearchHistoryUsecase,
         repositoryInteractor: SearchRepositoryUsecase) {
        self.view = view
        self.router = router
        self.historyInteractor = historyInteractor
        self.repositoryInteractor = repositoryInteractor
    }
}

// Presenterのプロトコルに準拠する
extension RepositoryListViewPresenter: RepositoryListViewPresentation {
    
    func viewDidLoad() {
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
    
    func refreshControlValueChanged(searchText: String) {
        self.searchText = searchText
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < repositories.count else { return }
        
        let repository = repositories[indexPath.row]
        router.showRepositoryDetail(repository) // Routerに画面遷移を依頼
    }
}
