//
//  RepositoryDetailPresenter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

class RepositoryDetailViewPresenter {

    private weak var view: RepositoryDetailView?
    private let router: RepositoryDetailWireframe
    private let repository: Repository

    init(view: RepositoryDetailView, router: RepositoryDetailWireframe, repository: Repository) {
        self.view = view
        self.router = router
        self.repository = repository
    }
}

extension RepositoryDetailViewPresenter: RepositoryDetailViewPresentable {

    func viewDidLoad() {
        view?.load(request: URLRequest(url: repository.htmlURL))
    }
}
