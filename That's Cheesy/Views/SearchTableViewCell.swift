//
//  SearchTableViewCell.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/13/23.
//

import UIKit

protocol SearchTableViewCellDelegate: AnyObject {
    func SearchTableViewCellDidTapCell(_ cell: SearchTableViewCell, viewModel: RecipeFullViewModel)
}

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    weak var delegate: SearchTableViewCellDelegate?
    
    let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // make responsive with UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 5, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(searchCollectionView)
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // display collection view
    override func layoutSubviews() {
        super.layoutSubviews()
        searchCollectionView.frame = contentView.bounds
    }

}


extension SearchTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.identifier, for: indexPath) as? RecipeCollectionViewCell else {
                return UICollectionViewCell()
        }
        let recipes = RecipeManager().getAllRecipes()
        cell.configure(with: (recipes[indexPath.row].image ?? UIImage(named: "imgCooking")?.toPngString() ?? ""))
        return cell
    }
    
    // creates recipe items for the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let recipes = RecipeManager().getAllRecipes()
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipes = RecipeManager().getAllRecipes()
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = recipes[indexPath.row].recipeName
        let image = recipes[indexPath.row].image
        let ingredients = recipes[indexPath.row].ingredients
        let instructions = recipes[indexPath.row].instructions
        let notes = recipes[indexPath.row].notes
        let saved = recipes[indexPath.row].saved
        
        let strongSelf = self
        
        let viewModel = RecipeFullViewModel(recipeName: title ?? "", image: image ?? "", ingredients: ingredients ?? "", instructions: instructions ?? "", notes: notes ?? "", saved: saved)
        self.delegate?.SearchTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
    }
}
