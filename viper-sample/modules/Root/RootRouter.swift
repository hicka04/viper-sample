//
//  RootRouter.swift
//  viper-sample
//
//  Created by hicka04 on 2018/07/26.
//  Copyright © 2018年 hicka04. All rights reserved.
//

import UIKit

class RootRouter {
    
    private init() {}
    
    static func showFirstView(window: UIWindow) {
        let firstView = RepositoryListRouter.assembleModules()
        let navigationController = UINavigationController(rootViewController: firstView)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
