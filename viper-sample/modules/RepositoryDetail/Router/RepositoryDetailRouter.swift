//
//  RepositoryDetailRouter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit

class RepositoryDetailRouter {

    weak var viewController: UIViewController?

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(repository: Repository) -> UIViewController {
        let view = RepositoryDetailViewController()
        let interactor = RepositoryDetailInteractor()
        let router = RepositoryDetailRouter(viewController: view)
        let presenter = RepositoryDetailViewPresenter(view: view, interactor: interactor, router: router, repository: repository)

        interactor.output = presenter
        view.presenter = presenter

        return view
    }
}

extension RepositoryDetailRouter: RepositoryDetailWireframe {

}
