//
//  RepositoryDetailViewController.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {

    var presenter: RepositoryDetailViewPresentable!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension RepositoryDetailViewController: RepositoryDetailView {

}
