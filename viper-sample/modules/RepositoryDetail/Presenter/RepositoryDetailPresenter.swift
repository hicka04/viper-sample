//
//  RepositoryDetailPresenter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

class RepositoryDetailViewPresenter {

    weak var view: RepositoryDetailView?
    let interactor: RepositoryDetailUsecase
    let router: RepositoryDetailWireframe
    let repository: Repository

    init(view: RepositoryDetailView, interactor: RepositoryDetailUsecase, router: RepositoryDetailWireframe, repository: Repository) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.repository = repository
    }
}

extension RepositoryDetailViewPresenter: RepositoryDetailViewPresentable {

    func viewDidLoad() {
        view?.load(request: URLRequest(url: repository.htmlURL))
    }
}

extension RepositoryDetailViewPresenter: RepositoryDetailInteractorOutput {

}
