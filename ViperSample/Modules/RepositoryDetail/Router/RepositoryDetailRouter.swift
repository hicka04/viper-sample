//
//  RepositoryDetailRouter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit

protocol RepositoryDetailWireframe: class {
    
}

final class RepositoryDetailRouter {

    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(repository: Repository) -> UIViewController {
        let view = RepositoryDetailViewController()
        let router = RepositoryDetailRouter(viewController: view)
        let presenter = RepositoryDetailViewPresenter(view: view, router: router, repository: repository)

        view.presenter = presenter

        return view
    }
}

extension RepositoryDetailRouter: RepositoryDetailWireframe {

}
