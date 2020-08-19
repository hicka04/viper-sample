//
//  RepositoryListViewPresenterTests.swift
//  viper-sampleTests
//
//  Created by hicka04 on 2019/07/18.
//  Copyright © 2019 hicka04. All rights reserved.
//

import XCTest
// `@testable import`をするとinternalなクラスやプロトコルにアクセスできるようになる
@testable import ViperSample

class RepositorySearchResultPresenterTests: XCTestCase {
    
    var view: ViewMock!
    var router: RouterMock!
    var historyInteractor: HistoryInteractorMock!
    var repositoryInteractor: RepositoryInteractorMock!
    var presenter: RepositorySearchResultPresenter!

    override func setUp() {
        super.setUp()
        
        view = .init()
        router = .init()
        historyInteractor = .init()
        repositoryInteractor = .init()
        presenter = .init(
            view: view,
            router: router,
            historyInteractor: historyInteractor,
            repositoryInteractor: repositoryInteractor
        )
    }

    override func tearDown() {
        
    }

    func test_viewDidLoad() {
        // PresenterにviewDidLoadのイベントが届いたときの挙動をテスト
        // Interactorに最後の検索文字列を取得するよう依頼する実装にしたので、
        // 正しく依頼されているかチェック
        XCTContext.runActivity(named: "viewDidLoad") { _ in
            XCTContext.runActivity(named: "when before called") { _ in
                XCTContext.runActivity(named: "`loadLastSeachText` is not called") { _ in
                    XCTAssertEqual(historyInteractor.callCount_loadLastSeachText, 0)
                }
            }
            
            XCTContext.runActivity(named: "when after called") { _ in
                presenter.viewDidLoad()
                
                XCTContext.runActivity(named: "`loadLastSeachText` is called") { _ in
                    XCTAssertEqual(historyInteractor.callCount_loadLastSeachText, 1)
                }
            }
        }
    }
    
    func test_searchButtonDidPush() {
        // PresenterにsearchButtonDidPushイベントが届いたときの挙動をテスト
        XCTContext.runActivity(named: "searchButtonDidPush") { _ in
            XCTContext.runActivity(named: "when before called") { _ in
                XCTContext.runActivity(named: "`fetchRepositories` is not called") { _ in
                    XCTAssertEqual(repositoryInteractor.callCount_fetchRepositories, 0)
                }
            }
            
            XCTContext.runActivity(named: "when after called") { _ in
                XCTContext.runActivity(named: "`fetchRepositories` is called") { _ in
                    presenter.searchButtonDidPush(searchText: "Swift")
                    XCTAssertEqual(repositoryInteractor.callCount_fetchRepositories, 1)
                }
                
                XCTContext.runActivity(named: "when `fetchRepositories` response error") { _ in
                    setUp()
                    repositoryInteractor = .init(result: .failure(NSError()))
                    presenter = .init(view: view,
                                      router: router,
                                      historyInteractor: historyInteractor,
                                      repositoryInteractor: repositoryInteractor)
                    
                    presenter.searchButtonDidPush(searchText: "Swift")
                    
                    XCTContext.runActivity(named: "`showErrorMessageView` is called") { _ in
                        XCTAssertEqual(view.callCount_showErrorAlert, 1)
                    }
                }
                
                XCTContext.runActivity(named: "when `fetchRepositories` response succeed") { _ in
                    setUp()
                    let repositories = [
                        Repository(id: 0,
                                   name: "Swift",
                                   fullName: "apple/Swift",
                                   htmlURL: URL(string: "https://github.com/apple/Swift/")!,
                                   starCount: 100000,
                                   owner: User(id: 0, login: "apple"))
                    ]
                    repositoryInteractor = .init(result: .success(repositories))
                    presenter = .init(view: view,
                                      router: router,
                                      historyInteractor: historyInteractor,
                                      repositoryInteractor: repositoryInteractor)
                    
                    presenter.searchButtonDidPush(searchText: "Swift")
                    
                    XCTContext.runActivity(named: "`updateRepositories` is called") { _ in
                        XCTAssertEqual(view.callCount_updateRepositories, 1)
                    }
                }
            }
        }
    }
    
    // MARK: - mock
    class ViewMock: RepositorySearchResultView {
        var callCount_setLastSearchText = 0
        func setLastSearchText(_ text: String) {
            callCount_setLastSearchText += 1
        }
        
        var callCount_showRefreshView = 0
        func showRefreshView() {
            callCount_showRefreshView += 1
        }
        
        var callCount_updateRepositories = 0
        func updateRepositories(_ repositories: [Repository]) {
            callCount_updateRepositories += 1
        }
        
        var callCount_showErrorAlert = 0
        func showErrorAlert() {
            callCount_showErrorAlert += 1
        }
    }
    
    class RouterMock: RepositorySearchResultWireframe {
        
        var isCalled_showRepositoryDetail = false
        func showRepositoryDetail(_ repository: Repository) {
            isCalled_showRepositoryDetail = true
        }
    }
    
    class HistoryInteractorMock: SearchHistoryUsecase {
        
        var callCount_loadLastSeachText = 0
        func loadLastSeachText(completion: (Result<String, SearchHistoryError>) -> Void) {
            callCount_loadLastSeachText += 1
        }
    }
    
    class RepositoryInteractorMock: SearchRepositoryUsecase {
        
        let result: Result<[Repository], Error>
        
        init(result: Result<[Repository], Error> = .failure(NSError())) {
            self.result = result
        }
        
        var callCount_fetchRepositories = 0
        func fetchRepositories(keyword: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
            callCount_fetchRepositories += 1
            completion(result)
        }
    }
}
