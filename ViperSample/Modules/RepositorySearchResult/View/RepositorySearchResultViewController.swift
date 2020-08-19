//
//  RepositorySearchResultViewController.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit

protocol RepositorySearchResultView: AnyObject {
    func updateRepositories(_ repositories: [Repository])
    func showErrorAlert()
}

final class RepositorySearchResultViewController: UITableViewController {
    // Presenterへのアクセスはprotocolを介して行う
    var presenter: RepositorySearchResultPresentation!
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "リポジトリ名を入力..."
        
        searchBar.delegate = self
        
        return searchBar
    }()
    
    private var repositories: [Repository] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData() // 画面の更新
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        
        tableView.register(RepositoryCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// Viewのプロトコルに準拠する
extension RepositorySearchResultViewController: RepositorySearchResultView {
    func updateRepositories(_ repositories: [Repository]) {
        self.repositories = repositories
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "ネットワークエラー", message: "しばらく時間をおいてから再度お試しください", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension RepositorySearchResultViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setRepository(repositories[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(repository: repositories[indexPath.row])
    }
}

extension RepositorySearchResultViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        presenter.searchButtonDidPush(searchText: text)
        
        searchBar.resignFirstResponder()
    }
}
