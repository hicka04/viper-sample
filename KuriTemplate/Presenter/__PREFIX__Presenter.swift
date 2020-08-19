//
//  __PREFIX__Presenter.swift
//  __TARGET__
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import Foundation

protocol __PREFIX__Presentation: AnyObject {
    func viewDidLoad()    
}

final class __PREFIX__Presenter {
    private weak var view: __PREFIX__View?
    private let router: __PREFIX__Wireframe
    
    init(
        view: __PREFIX__View,
        router: __PREFIX__Wireframe
    ) {
        self.view = view
        self.router = router
    }
}

extension __PREFIX__Presenter: __PREFIX__Presentation {
    func viewDidLoad() {
        
    }
}

