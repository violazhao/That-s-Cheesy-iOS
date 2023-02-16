//
//  SearchViewController.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/9/23.
//

import UIKit

// search page
class SearchViewController: UIViewController {
    
    private let searchTable: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a recipe"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        RecipeManager.shared.loadFiltered()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchTable)

        searchTable.delegate = self
        searchTable.dataSource = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    // creates one row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // determines which cell to dequeue for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        return cell
    }
    
    // each cell has a height of 200
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let remainder = RecipeManager.shared.recipes.count % 3
        if remainder > 0 {
            return CGFloat((200 * (RecipeManager.shared.recipes.count / 2)) - 200)
        } else {
            return CGFloat(200 * (RecipeManager.shared.recipes.count / 3))
        }
    }
}

extension SearchViewController: SearchTableViewCellDelegate {
    func SearchTableViewCellDidTapCell(_ cell: SearchTableViewCell, viewModel: RecipeFullViewModel) {
        let recipeFull = RecipeFullViewController()
        recipeFull.configure(with: viewModel)
        navigationController?.pushViewController(recipeFull, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
          !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        print(query)
        RecipeManager.shared.search(with: query)
    }
}
