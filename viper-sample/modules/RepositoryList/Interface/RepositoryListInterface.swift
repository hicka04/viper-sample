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

    func reloadData()
}

// MARK: - presenter
protocol RepositoryListViewPresentable: class {

    func viewDidLoad()
    func searchTextDidChange(text: String)
    func numberOfRow(in section: Int) -> Int
    func repository(at indexPath: IndexPath) -> Repository
    func didSelectRow(at indexPath: IndexPath)
}

// MARK: - interactor
protocol RepositoryListUsecase: class {

    var numberOfRepositories: Int { get }
    func repository(at indexPath: IndexPath) -> Repository
    func fetchRepositories(keyword: String)
}

protocol RepositoryListInteractorOutput: class {

    func fetchRepositoriesDidFinish()
}

// MARK: - router
protocol RepositoryListWireframe: class {

    func showRepositoryDetail(_ repository: Repository)
}
