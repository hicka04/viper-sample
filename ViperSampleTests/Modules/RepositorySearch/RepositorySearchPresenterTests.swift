//
//  RepositorySearchPresenterTests.swift
//  ViperSampleTests
//
//  Created by hicka04 on 2020/02/28.
//

import Quick
import Nimble
@testable import ViperSample
import ViperSampleDomain

class RepositorySearchPresenterTests: QuickSpec {
    
    override func spec() {
        let view = SpyView()
        let router = SpyRouter()
        let interactor = MockRepositorySearchInteractor()
        let presenter = RepositorySearchPresenter(view: view, router: router, interactor: interactor)
        describe("searchButtonClicked") {
            context("when return search results") {
                interactor.result = .success([])
                it("called view.update") {
                    let callCount = view.updateCallCount
                    presenter.searchButtonClicked(keyword: "hoge")
                    expect(view.updateCallCount).to(equal(callCount + 1))
                }
            }
        }
    }
}

class MockRepositorySearchInteractor: RepositorySearchUsecase {
    
    var result: Result<[Repository], Error>?
    func search(keyword: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        completion(result!)
    }
}

class SpyView: RepositorySearchView {
    
    var updateCallCount = 0
    func update(repositories: [Repository]) {
        updateCallCount += 1
    }
}

class SpyRouter: RepositorySearchWireframe {
    
}
