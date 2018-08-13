//
//  RepositoryListViewController.swift
//  viper-sample
//
//  Created by hicka04 on 26/07/2018.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController {

    // Presenterへのアクセスはprotocolを介して行う
    var presenter: RepositoryListViewPresentable!
    
    @IBOutlet private weak var tableView: UITableView!
    private let cellId = "cellId"
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "リポジトリ名を入力..."
        
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(RepositoryResultCell.createNib(), forCellReuseIdentifier: cellId)
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar

        presenter.viewDidLoad() // Viewの読み込みが完了したことを通知
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// Viewのプロトコルに準拠する
extension RepositoryListViewController: RepositoryListView {
    
    func reloadData() {
        tableView.reloadData() // 画面の更新
    }
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepositoryResultCell
        let repository = presenter.repository(at: indexPath)
        cell.setRepository(repository)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

extension RepositoryListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        presenter.searchTextDidChange(text: searchText)
    }
}
