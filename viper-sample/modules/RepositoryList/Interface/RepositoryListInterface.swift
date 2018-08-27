//
//  RepositoryListInterface.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

// MARK: - view
protocol RepositoryListView: class {

    func setLastSearchText(_ text: String)
    func showRefreshView()
    func reloadData(_ data: [RepositoryListCellType])
}

// MARK: - presenter
protocol RepositoryListViewPresentable: class {

    func viewDidLoad()
    func searchButtonDidPush(searchText: String)
    func refreshControlValueChanged(searchText: String)
    func didSelectRow(at indexPath: IndexPath)
}

// MARK: - interactor
protocol RepositoryListUsecase: class {

    func loadLastSearchText()
    func fetchRepositories(keyword: String)
}

protocol RepositoryListInteractorDelegate: class {
    
    func interactor(_ interactor: RepositoryListUsecase, didFinishLoad lastSearchText: String)
    func interactor(_ interactor: RepositoryListUsecase, didFailedLoadLastSearchTextWithError error: Error)

    func interactor(_ interactor: RepositoryListUsecase, didFetchedRepositories repositories: [Repository])
    func interactor(_ interactor: RepositoryListUsecase, didFailedWithError error: Error)
}

// MARK: - router
protocol RepositoryListWireframe: class {

    func showRepositoryDetail(_ repository: Repository)
}
