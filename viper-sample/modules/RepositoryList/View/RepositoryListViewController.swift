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
    private let errorCellId = "errorCellId"
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "リポジトリ名を入力..."
        
        return searchBar
    }()
    private lazy var searchButton: UIBarButtonItem = UIBarButtonItem(title: "Search",
                                                                     style: .done,
                                                                     target: self,
                                                                     action: #selector(searchButtonDidPush))
    
    private var data: [RepositoryListCellType] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(RepositoryResultCell.createNib(), forCellReuseIdentifier: cellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: errorCellId)
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = searchButton
        searchButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc private func searchButtonDidPush() {
        guard let text = searchBar.text else { return }
        
        presenter.searchButtonDidPush(text: text)
    }
}

// Viewのプロトコルに準拠する
extension RepositoryListViewController: RepositoryListView {
    
    func reloadData(_ data: [RepositoryListCellType]) {
        self.data = data
        tableView.reloadData() // 画面の更新
    }
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch data[indexPath.row] {
        case .repositoryCell(let repository):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepositoryResultCell
            cell.setRepository(repository)
            
            return cell
        case .errorCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: errorCellId, for: indexPath)
            cell.textLabel?.text = "エラーが発生しました"
            cell.isUserInteractionEnabled = false
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

extension RepositoryListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchButton.isEnabled = !searchText.isEmpty
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonDidPush()
    }
}
