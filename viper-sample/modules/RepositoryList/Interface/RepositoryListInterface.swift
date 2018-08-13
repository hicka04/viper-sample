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

    func reloadData(_ data: [RepositoryListCellType])
}

// MARK: - presenter
protocol RepositoryListViewPresentable: class {

    func searchButtonDidPush(text: String)
    func didSelectRow(at indexPath: IndexPath)
}

// MARK: - interactor
protocol RepositoryListUsecase: class {

    func fetchRepositories(keyword: String)
}

protocol RepositoryListInteractorDelegate: class {

    func interactor(_ interactor: RepositoryListUsecase, didFetchedRepositories repositories: [Repository])
    func interactor(_ interactor: RepositoryListUsecase, didFailedWithError error: Error)
}

// MARK: - router
protocol RepositoryListWireframe: class {

    func showRepositoryDetail(_ repository: Repository)
}
