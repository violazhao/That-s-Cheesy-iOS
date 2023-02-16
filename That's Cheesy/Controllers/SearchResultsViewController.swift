//
//  SearchResultsViewController.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/12/23.
//

import UIKit

class SearchResultsViewController: UIViewController {
        
    private let searchTable: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchTable)

        searchTable.delegate = self
        searchTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }

}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        return cell
    }
    
    // each cell has a height of 200
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let remainder = RecipeManager.shared.filtered.count % 3
        if remainder > 0 {
            return CGFloat((200 * (RecipeManager.shared.filtered.count / 2)) - 200)
        } else {
            return CGFloat(200 * (RecipeManager.shared.filtered.count / 3))
        }
    }
}

extension SearchResultsViewController: SearchTableViewCellDelegate {
    func SearchTableViewCellDidTapCell(_ cell: SearchTableViewCell, viewModel: RecipeFullViewModel) {
        let recipeFull = RecipeFullViewController()
        recipeFull.configure(with: viewModel)
        navigationController?.pushViewController(recipeFull, animated: true)
    }
}
