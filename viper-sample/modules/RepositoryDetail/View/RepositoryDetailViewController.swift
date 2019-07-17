//
//  RepositoryDetailViewController.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit
import WebKit

protocol RepositoryDetailView: class {
    
    func load(request urlRequest: URLRequest)
}

final class RepositoryDetailViewController: UIViewController {

    var presenter: RepositoryDetailViewPresentation!
    
    @IBOutlet private weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension RepositoryDetailViewController: RepositoryDetailView {

    func load(request urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
}
