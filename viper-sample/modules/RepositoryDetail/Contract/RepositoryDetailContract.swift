//
//  RepositoryDetailInterface.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import Foundation

// MARK: - view
protocol RepositoryDetailView: class {

    func load(request urlRequest: URLRequest)
}

// MARK: - presenter
protocol RepositoryDetailViewPresentable: class {

    func viewDidLoad()
}

// MARK: - interactor
protocol RepositoryDetailUsecase: class {

}

protocol RepositoryDetailInteractorOutput: class {

}

// MARK: - router
protocol RepositoryDetailWireframe: class {

}
