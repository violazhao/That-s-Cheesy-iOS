//
//  CollectionViewTableViewCell.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/9/23.
//

import UIKit

// allows cell to be clicked
protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: RecipeFullViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    // creating collection view for the carousel
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        // horizontal layout
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // display collection view
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.identifier, for: indexPath) as? RecipeCollectionViewCell else {
                return UICollectionViewCell()
        }
        let recipes = RecipeManager().getAllRecipes()
//        print(recipes, recipes[indexPath.row].objectID)
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
        let id = recipes[indexPath.row].objectID
        
        let strongSelf = self
        
        let viewModel = RecipeFullViewModel(id: id, recipeName: title ?? "", image: image ?? "", ingredients: ingredients ?? "", instructions: instructions ?? "", notes: notes ?? "", saved: saved)
        self.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
    }
}

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
