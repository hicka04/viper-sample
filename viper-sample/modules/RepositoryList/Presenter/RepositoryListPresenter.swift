//
//  RepositoryListPresenter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

class RepositoryListViewPresenter {

    // View, Interactor, Routerへのアクセスはprotocolを介して行う
    weak var view: RepositoryListView?
    let interactor: RepositoryListUsecase
    let router: RepositoryListWireframe

    init(view: RepositoryListView, interactor: RepositoryListUsecase, router: RepositoryListWireframe) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// Presenterのプロトコルに準拠する
extension RepositoryListViewPresenter: RepositoryListViewPresentable {

    func viewDidLoad() {
//        interactor.fetchRepositories(keyword: "swift") // Interactorにデータ取得処理を依頼
        view?.reloadData()
    }
    
    func searchTextDidChange(text: String) {
        interactor.fetchRepositories(keyword: text)
    }
    
    func numberOfRow(in section: Int) -> Int {
        return interactor.numberOfRepositories
    }
    
    func repository(at indexPath: IndexPath) -> Repository {
        return interactor.repository(at: indexPath)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        router.showRepositoryDetail(repository(at: indexPath)) // Routerに画面遷移を依頼
    }
}

// Interactorからの通知に関するプロトコルに準拠する
extension RepositoryListViewPresenter: RepositoryListInteractorOutput {

    func fetchRepositoriesDidFinish() {
        view?.reloadData() // データ取得が完了したら画面の更新を依頼
        print(interactor.numberOfRepositories)
    }
}
