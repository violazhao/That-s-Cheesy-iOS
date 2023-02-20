//
//  HomeViewController.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/9/23.
//

import UIKit

// homepage
class HomeViewController: UIViewController {
    
    // header title "That's Cheesy"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // header image cheese emoji
    private let cheeseImage: UIImageView = {
        let cheese = UIImage(named: "cheeseEmoji")
        let cheeseView = UIImageView(image: cheese)
        cheeseView.translatesAutoresizingMaskIntoConstraints = false
        return cheeseView
    }()
    
    // table view for home 
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.backgroundColor = .systemBackground
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        RecipeManager().deleteAllData(entity: "Recipe")
        
        view.backgroundColor = .systemBackground

        view.addSubview(cheeseImage)
        
        titleLabel.text = "That's Cheesy"
        view.addSubview(titleLabel)

        view.addSubview(homeFeedTable)
        
        // header for the current image
        let headerImageView = HomeImageUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        homeFeedTable.tableHeaderView = headerImageView
        
        // allow adding data to cells
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
                
        applyConstraints()
        
    }
    
    // to do: should reloading be called in viewWillAppear or viewDidAppear?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let recipeCarouselCell = homeFeedTable.cellForRow(at: IndexPath(row: 0, section: 0)) as? CollectionViewTableViewCell {
            recipeCarouselCell.collectionView.reloadData()
        }
    }
    
    // applying constraints to each header item
    private func applyConstraints() {
        let cheeseConstraints = [
            cheeseImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            cheeseImage.widthAnchor.constraint(equalToConstant: 40),
            cheeseImage.heightAnchor.constraint(equalToConstant: 42),
            cheeseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cheeseImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10)
        ]
        
        let titleConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: homeFeedTable.topAnchor, constant: -10)
        ]

        let tableConstraints = [
            homeFeedTable
                .centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeFeedTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeFeedTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeFeedTable.heightAnchor.constraint(equalToConstant: 600)
        ]
        
        NSLayoutConstraint.activate(cheeseConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(tableConstraints)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    // creates one section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // creates one row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // determines which cell to dequeue for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        homeFeedTable.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        cell.delegate = self
        return cell
    }
    
    // each cell has a height of 200
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // separates each cell by 20
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: RecipeFullViewModel) {
        let recipeFull = RecipeFullViewController()
        recipeFull.configure(with: viewModel)
        navigationController?.pushViewController(recipeFull, animated: true)
    }
}
