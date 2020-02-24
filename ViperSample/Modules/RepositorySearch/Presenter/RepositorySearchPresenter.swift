//
//  RepositorySearchPresenter.swift
//  ViperSample
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation

struct Repository {
    let id: Int
}

protocol RepositorySearchPresentation: AnyObject {
    
    func searchButtonClicked(keyword: String)
}

final class RepositorySearchPresenter<View: RepositorySearchView, Router: RepositorySearchRouter> {
    
    private weak var view: View?
    private let router: Router
    
    init(view: View, router: Router) {
        self.view = view
        self.router = router
    }
}

extension RepositorySearchPresenter: RepositorySearchPresentation {
    
    func searchButtonClicked(keyword: String) {
        view?.update(repositories: (0..<10).map(Repository.init))
    }
}
