//
//  RepositoryListInterface.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

// MARK: - view
protocol RepositoryListView: class {

}

// MARK: - presenter
protocol RepositoryListViewPresentable: class {

    func viewDidLoad()
}

// MARK: - interactor
protocol RepositoryListUsecase: class {

}

protocol RepositoryListInteractorOutput: class {

}

// MARK: - router
protocol RepositoryListWireframe: class {

}
