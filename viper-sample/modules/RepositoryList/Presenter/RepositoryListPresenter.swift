//
//  RepositoryListPresenter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

enum RepositoryListCellType {
    
    case repositoryCell(repository: Repository)
    case errorCell(error: Error)
    case noHistoryCell
}

class RepositoryListViewPresenter {

    // View, Interactor, Routerへのアクセスはprotocolを介して行う
    private weak var view: RepositoryListView?
    private let interactor: RepositoryListUsecase
    private let router: RepositoryListWireframe
    private var searchText: String = "" {
        didSet {
            guard !searchText.isEmpty else { return }
            
            view?.setLastSearchText(searchText)
            view?.showRefreshView()
            interactor.fetchRepositories(keyword: searchText)
        }
    }
    
    private var repositories: [Repository] = [] {
        didSet {
            guard !repositories.isEmpty else { return }
            
            cellTypes = repositories.map { repository in
                RepositoryListCellType.repositoryCell(repository: repository)
            }
        }
    }
    private var cellTypes: [RepositoryListCellType] = [] {
        didSet {
            view?.reloadData(cellTypes)
        }
    }

    init(view: RepositoryListView, interactor: RepositoryListUsecase, router: RepositoryListWireframe) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// Presenterのプロトコルに準拠する
extension RepositoryListViewPresenter: RepositoryListViewPresentable {
    
    func viewDidLoad() {
        interactor.loadLastSearchText()
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

// Interactorからの通知に関するプロトコルに準拠する
extension RepositoryListViewPresenter: RepositoryListInteractorDelegate {
    
    func interactor(_ interactor: RepositoryListUsecase, didFinishLoad lastSearchText: String) {
        searchText = lastSearchText
    }
    
    func interactor(_ interactor: RepositoryListUsecase, didFailedLoadLastSearchTextWithError error: Error) {
        cellTypes = [.noHistoryCell]
    }

    func interactor(_ interactor: RepositoryListUsecase, didFetchedRepositories repositories: [Repository]) {
        self.repositories = repositories
    }
    
    func interactor(_ interactor: RepositoryListUsecase, didFailedWithError error: Error) {
        repositories.removeAll()
        cellTypes = [.errorCell(error: error)]
    }
}
