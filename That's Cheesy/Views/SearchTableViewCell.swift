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
    
    public let searchCollectionView: UICollectionView = {
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
        cell.configure(with: (RecipeManager.shared.recipes[indexPath.row].image ?? UIImage(named: "imgCooking")?.toPngString() ?? ""))
        return cell
    }
    
    // creates recipe items for the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RecipeManager.shared.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = RecipeManager.shared.recipes[indexPath.row].recipeName
        let image = RecipeManager.shared.recipes[indexPath.row].image
        let ingredients = RecipeManager.shared.recipes[indexPath.row].ingredients
        let instructions = RecipeManager.shared.recipes[indexPath.row].instructions
        let notes = RecipeManager.shared.recipes[indexPath.row].notes
        let saved = RecipeManager.shared.recipes[indexPath.row].saved
        
        let strongSelf = self
        
        let viewModel = RecipeFullViewModel(recipeName: title, image: image, ingredients: ingredients, instructions: instructions, notes: notes, saved: saved)
        self.delegate?.SearchTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
    }
}
