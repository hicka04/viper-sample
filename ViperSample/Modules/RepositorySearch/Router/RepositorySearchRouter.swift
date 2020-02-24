//
//  RepositorySearchRouter.swift
//  ViperSample
//
//  Created by hicka04 on 2020/02/24.
//

import UIKit
import ViperSampleDomain

protocol RepositorySearchWireframe: AnyObject {
    
}

final class RepositorySearchRouter {
    
    private unowned let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModules() -> UIViewController {
        let view = RepositorySearchViewController()
        let router = RepositorySearchRouter(viewController: view)
        let interactor = RepositorySearchInteractor()
        let presenter = RepositorySearchPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        
        return view
    }
}

extension RepositorySearchRouter: RepositorySearchWireframe {
    
}
