//
//  RepositoryListRouter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit

class RepositoryListRouter {

    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = RepositoryListViewController()
        let interactor = RepositoryListInteractor()
        let router = RepositoryListRouter(viewController: view)
        let presenter = RepositoryListViewPresenter(view: view, interactor: interactor, router: router)

        interactor.output = presenter
        view.presenter = presenter

        return view
    }
}

extension RepositoryListRouter: RepositoryListWireframe {

}
