//
//  RepositoryListPresenterTest.swift
//  viper-sampleTests
//
//  Created by hicka04 on 2018/07/31.
//  Copyright © 2018年 hicka04. All rights reserved.
//

import XCTest

class RepositoryListPresenterTest: XCTestCase {
    
    // 依存するクラスの初期化
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
        // PresenterにviewDidLoadのイベントが届いたときの挙動をテスト
        // Interactorに最後の検索文字列を取得するよう依頼する実装にしたので、
        // 正しく依頼されているかチェック
        XCTContext.runActivity(named: "viewDidLoadが呼ばれたとき") { _ in
            let before = interactor.callCount_loadLastSearchText
            presenter.viewDidLoad()
            
            XCTContext.runActivity(named: "最後の検索文字列の取得が実行されるか") { _ in
                XCTAssertEqual(before + 1, interactor.callCount_loadLastSearchText)
            }
        }
    }
    
    func test_fetchRepositoriesDidFinish() {
        // Presenterにリポジトリ一覧の取得完了イベントが届いたときの挙動テスト
        // イベントを受け取ったらViewに再描画を依頼するよう実装したので、
        // 正しく依頼されているかチェック
        XCTContext.runActivity(named: "リポジトリ一覧の取得が完了したとき") { _ in
            let before = view.callCount_reloadData
            
            XCTContext.runActivity(named: "取得結果が0件だったら") { _ in
                presenter.interactor(interactor, didFetchedRepositories: [])
                XCTContext.runActivity(named: "画面の再描画が実行されない") { _ in
                    XCTAssertEqual(before, view.callCount_reloadData)
                }
            }
            
            XCTContext.runActivity(named: "取得結果が1件以上だったら") { _ in
                let data = """
                            {
                            "id": 44838949,
                            "name": "swift",
                            "full_name": "apple/swift",
                            "owner": {
                            "login": "apple",
                            "id": 10639145
                            },
                            "html_url": "https://github.com/apple/swift",
                            "stargazers_count": 45700
                            }
                            """.data(using: .utf8)!
                let repository = try! JSONDecoder().decode(Repository.self, from: data)
                presenter.interactor(interactor, didFetchedRepositories: [repository])
                XCTContext.runActivity(named: "画面の再描画が実行される") { _ in
                    XCTAssertEqual(before + 1, view.callCount_reloadData)
                }
            }
        }
    }
    
    // MARK: mock
    class ViewMock: RepositoryListView {
        
        var callCount_setLastSearchText = 0
        func setLastSearchText(_ text: String) {
            callCount_setLastSearchText += 1
        }
        
        var callCount_showRefreshView = 0
        func showRefreshView() {
            callCount_showRefreshView += 1
        }
        
        var callCount_reloadData = 0
        func reloadData(_ data: [RepositoryListCellType]) {
            callCount_reloadData += 1
        }
    }
    
    class InteractorMock: RepositoryListUsecase {
        var callCount_loadLastSearchText = 0
        func loadLastSearchText() {
            callCount_loadLastSearchText += 1
        }
        
        var callCount_fetchRepositories = false
        func fetchRepositories(keyword: String) {
            callCount_fetchRepositories = true
        }
    }
    
    class RouterMock: RepositoryListWireframe {
        
        var isCalled_showRepositoryDetail = false
        
        func showRepositoryDetail(_ repository: Repository) {
            isCalled_showRepositoryDetail = true
        }
    }
}
