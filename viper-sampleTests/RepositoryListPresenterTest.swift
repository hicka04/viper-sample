//
//  RepositoryListPresenterTest.swift
//  viper-sampleTests
//
//  Created by hicka04 on 2018/07/31.
//  Copyright © 2018年 hicka04. All rights reserved.
//

import XCTest

class RepositoryListPresenterTest: XCTestCase {
    
    let view = ViewMock()
    let interactor = InteractorMock()
    let router = RouterMock()
    var presenter: RepositoryListViewPresenter!
    
    override func setUp() {
        super.setUp()
        
        presenter = RepositoryListViewPresenter(view: view, interactor: interactor, router: router)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        XCTAssertFalse(interactor.isCalled_fetchRepositories)
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.isCalled_fetchRepositories)
    }
    
    func test_fetchRepositoriesDidFinish() {
        XCTAssertFalse(view.isCalled_reloadData)
        presenter.fetchRepositoriesDidFinish()
        XCTAssertTrue(view.isCalled_reloadData)
    }
    
    // MARK: mock
    class ViewMock: RepositoryListView {
        
        var isCalled_reloadData = false
        
        func reloadData() {
            isCalled_reloadData = true
        }
    }
    
    class InteractorMock: RepositoryListUsecase {
        
        var isCalled_fetchRepositories = false
        
        var numberOfRepositories: Int = 0
        
        func repository(at indexPath: IndexPath) -> Repository {
            let user = User(id: 1, login: "apple")
            return Repository(id: 1, name: "swift", fullName: "apple/swift", htmlURL: URL(string: "https://www.google.com")!, starCount: 1000, owner: user)
        }
        
        func fetchRepositories(keyword: String) {
            isCalled_fetchRepositories = true
        }
    }
    
    class RouterMock: RepositoryListWireframe {
        
        var isCalled_showRepositoryDetail = false
        
        func showRepositoryDetail(_ repository: Repository) {
            isCalled_showRepositoryDetail = true
        }
    }
}
