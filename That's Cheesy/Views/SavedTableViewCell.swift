//
//  SavedTableViewCell.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/14/23.
//

import UIKit

// allows cell to be clicked
protocol SavedTableViewCellDelegate: AnyObject {
    func savedTableViewCellDidTapCell(_ cell: SavedTableViewCell, viewModel: RecipeFullViewModel)
}

class SavedTableViewCell: UITableViewCell {

    static let identifier = "SavedTableViewCell"
    
    weak var delegate: SavedTableViewCellDelegate?
    
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
        
        collectionView.reloadData()
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

extension SavedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.identifier, for: indexPath) as? RecipeCollectionViewCell else {
                return UICollectionViewCell()
        }
        let saves = RecipeManager().getAllSaved()
        cell.configure(with: (saves[indexPath.row].image ?? UIImage(named: "imgCooking")?.toPngString() ?? ""))
        return cell
    }
    
    // creates recipe items for the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let saves = RecipeManager().getAllSaved()
        return saves.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let saves = RecipeManager().getAllSaved()
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = saves[indexPath.row].recipeName
        let image = saves[indexPath.row].image
        let ingredients = saves[indexPath.row].ingredients
        let instructions = saves[indexPath.row].instructions
        let notes = saves[indexPath.row].notes
        let saved = saves[indexPath.row].saved
        
        let strongSelf = self
        
        let viewModel = RecipeFullViewModel(recipeName: title ?? "", image: image ?? "", ingredients: ingredients ?? "", instructions: instructions ?? "", notes: notes ?? "", saved: saved)
        self.delegate?.savedTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
    }
}
