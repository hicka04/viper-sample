//
//  RepositoryListPresenter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

class RepositoryListViewPresenter {

    weak var view: RepositoryListView?
    let interactor: RepositoryListUsecase
    let router: RepositoryListWireframe

    init(view: RepositoryListView, interactor: RepositoryListUsecase, router: RepositoryListWireframe) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension RepositoryListViewPresenter: RepositoryListViewPresentable {

    func viewDidLoad() {
        interactor.fetchRepositories(keyword: "swift")
    }
    
    func numberOfRow(in section: Int) -> Int {
        return interactor.numberOfRepositories
    }
    
    func repository(at indexPath: IndexPath) -> Repository {
        return interactor.repository(at: indexPath)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        router.showRepositoryDetail(repository(at: indexPath))
    }
}

extension RepositoryListViewPresenter: RepositoryListInteractorOutput {

    func fetchRepositoriesDidFinish() {
        view?.reloadData()
    }
}
