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
        self.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
    }
}

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
