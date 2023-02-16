//
//  TitleCollectionViewCell.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/10/23.
//

import UIKit
import SDWebImage

class RecipeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecipeCollectionViewCell"
        
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true // prevents poster from overflowing container
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(recipeImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        recipeImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: "\(model)") else { return }
        recipeImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "imgCooking"), completed: nil)
    }
}
