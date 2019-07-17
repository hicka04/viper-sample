//
//  RepositoryListViewController.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit

protocol RepositoryListView: AnyObject {
    
    func setLastSearchText(_ text: String)
    func showRefreshView()
    func updateRepositories(_ repositories: [Repository])
    func showErrorMessageView(reason: String)
}

final class RepositoryListViewController: UIViewController {

    // Presenterへのアクセスはprotocolを介して行う
    var presenter: RepositoryListViewPresentation!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(RepositoryCell.self)
            tableView.refreshControl = refreshControl
        }
    }
    @IBOutlet private weak var errorMessageLabel: UILabel!
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "リポジトリ名を入力..."
        
        searchBar.delegate = self
        
        return searchBar
    }()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    private var repositories: [Repository] = [] {
        didSet {
            DispatchQueue.main.async {
                self.errorMessageLabel.isHidden = true
                self.tableView.reloadData() // 画面の更新
                
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        guard let text = searchBar.text else { return }
        
        presenter.refreshControlValueChanged(searchText: text)
    }
}

// Viewのプロトコルに準拠する
extension RepositoryListViewController: RepositoryListView {
    
    func setLastSearchText(_ text: String) {
        searchBar.text = text
    }
    
    func showRefreshView() {
        guard !refreshControl.isRefreshing else { return }
        
        refreshControl.beginRefreshingManually(in: tableView)
    }
    
    func updateRepositories(_ repositories: [Repository]) {
        self.repositories = repositories
    }
    
    func showErrorMessageView(reason: String) {
        DispatchQueue.main.async {
            self.errorMessageLabel.text = reason
            self.errorMessageLabel.isHidden = false
        }
    }
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setRepository(repositories[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

extension RepositoryListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        presenter.searchButtonDidPush(searchText: text)
        
        searchBar.resignFirstResponder()
    }
}
