//
//  RepositorySearchRouter.swift
//  ViperSample
//
//  Created by hicka04 on 2020/02/24.
//

import UIKit

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
        let presenter = RepositorySearchPresenter(view: view, router: router)
        
        view.presenter = presenter
        
        return view
    }
}

extension RepositorySearchRouter: RepositorySearchWireframe {
    
}
