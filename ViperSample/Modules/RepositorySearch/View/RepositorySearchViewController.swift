//
//  RepositorySearchViewController.swift
//  ViperSample
//
//  Created by hicka04 on 2020/02/24.
//

import UIKit
import ViperSampleDomain

protocol RepositorySearchView: AnyObject {
    
    func update(repositories: [Repository])
}

class RepositorySearchViewController: UITableViewController {
    
    var presenter: RepositorySearchPresentation!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Enter keywords"
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private var repositories: [Repository] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        clearsSelectionOnViewWillAppear = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = repositories[indexPath.row].fullName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension RepositorySearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        presenter.searchButtonClicked(keyword: keyword)
        searchController.dismiss(animated: true, completion: nil)
    }
}

extension RepositorySearchViewController: RepositorySearchView {
    
    func update(repositories: [Repository]) {
        self.repositories = repositories
    }
}
