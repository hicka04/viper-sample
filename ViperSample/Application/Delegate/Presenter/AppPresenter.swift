//
//  AppPresenter.swift
//  ViperSample
//
//  Created by hicka04 on 2020/08/19.
//  Copyright © 2020 hicka04. All rights reserved.
//

import Foundation

protocol AppPresentation: AnyObject {
    func didFinishLaunch()
}

final class AppPresenter {
    private let router: AppWireframe
    
    init(router: AppWireframe) {
        self.router = router
    }
}

extension AppPresenter: AppPresentation {
    func didFinishLaunch() {
        router.showRepositorySearchResultView()
    }
}
