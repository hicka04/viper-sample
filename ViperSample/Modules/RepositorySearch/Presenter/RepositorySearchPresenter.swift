//
//  RepositorySearchPresenter.swift
//  ViperSample
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation
import ViperSampleDomain

protocol RepositorySearchPresentation: AnyObject {
    
    func searchButtonClicked(keyword: String)
}

final class RepositorySearchPresenter<View: RepositorySearchView, Router: RepositorySearchWireframe, Interactor: RepositorySearchUsecase> {
    
    private weak var view: View?
    private let router: Router
    private let interactor: Interactor
    
    init(view: View, router: Router, interactor: Interactor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension RepositorySearchPresenter: RepositorySearchPresentation {
    
    func searchButtonClicked(keyword: String) {
        interactor.search(keyword: keyword) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.view?.update(repositories: repositories)
            case .failure:
                break
            }
        }
    }
}
