//
//  RepositorySearchResultRouter.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit

protocol RepositorySearchResultWireframe: AnyObject {
    func showRepositoryDetail(_ repository: Repository)
}

final class RepositorySearchResultRouter {
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules() -> UIViewController {
        let view = RepositorySearchResultViewController()
        let router = RepositorySearchResultRouter(viewController: view)
        let searchRepositoryInteractor = SearchRepositoryInteractor()
        // PresenterはView, Interactor, Routerそれぞれ必要なので
        // 生成し、initの引数で渡す
        let presenter = RepositorySearchResultPresenter(
            view: view,
            router: router,
            searchRepositoryInteractor: searchRepositoryInteractor
        )

        view.presenter = presenter    // ViewにPresenterを設定

        return view
    }
}

// Routerのプロトコルに準拠する
// 遷移する各画面ごとにメソッドを定義
extension RepositorySearchResultRouter: RepositorySearchResultWireframe {
    func showRepositoryDetail(_ repository: Repository) {
        // 詳細画面のRouterに依存関係の解決を依頼
        let detailView = RepositoryDetailRouter.assembleModules(repository: repository)
        // 詳細画面に遷移
        // ここで、init時に受け取ったViewControllerを使う
        viewController.navigationController?.pushViewController(detailView, animated: true)
    }
}
