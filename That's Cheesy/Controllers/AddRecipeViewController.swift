//
//  AddRecipeViewController.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/9/23.
//

import UIKit

var added = 0
// add recipe page
class AddRecipeViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var contentView = UIView()

    func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + 80))
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.contentSize = contentView.bounds.size
   }
    
    // header title "Add Recipe"
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
    
    private let titleField: UITextField = {
        let title = UITextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.placeholder = "Title"
        title.borderStyle = UITextField.BorderStyle.roundedRect
        return title
    }()
    
    // temp image
    private let tempImage: UIImageView = {
        let tempImage = UIImage(named: "imgCookingSq")
        let tempImageView = UIImageView(image: tempImage)
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        return tempImageView
    }()
    
    private let imageURL: UITextField = {
        let imageURL = UITextField()
        imageURL.translatesAutoresizingMaskIntoConstraints = false
        imageURL.placeholder = "Image URL"
        imageURL.borderStyle = UITextField.BorderStyle.roundedRect
        return imageURL
    }()
    
    private let ingredients: UITextField = {
        let ingredients = UITextField()
        ingredients.translatesAutoresizingMaskIntoConstraints = false
        ingredients.placeholder = "Ingredients"
        ingredients.borderStyle = UITextField.BorderStyle.roundedRect
        return ingredients
    }()
    
    private let instructions: UITextField = {
        let instructions = UITextField()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.placeholder = "Instructions"
        instructions.borderStyle = UITextField.BorderStyle.roundedRect
        return instructions
    }()
    
    private let notes: UITextField = {
        let notes = UITextField()
        notes.translatesAutoresizingMaskIntoConstraints = false
        notes.placeholder = "Personal notes"
        notes.borderStyle = UITextField.BorderStyle.roundedRect
        return notes
    }()
    
    lazy var addBtn: UIButton = {
        let add = UIButton()
        add.translatesAutoresizingMaskIntoConstraints = false
        add.setTitle("Add", for: .normal)
        add.setTitleColor(.label, for: .normal)
        add.backgroundColor = UIColor(rgb: 0xffa700)
        add.layer.cornerRadius = 8
        add.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return add
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        RecipeManager().addRecipe(recipeName: titleField.text ?? "", image: imageURL.text ?? "", ingredients: ingredients.text ?? "", instructions: instructions.text ?? "", notes: notes.text ?? "", saved: false)
        added += 1
        print("added: \(titleField.text ?? "")")
        titleField.text = nil
        imageURL.text = nil
        ingredients.text = nil
        instructions.text = nil
        notes.text = nil
    }
    
    @objc func dismissKeyboard() {
        contentView.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        
        view.backgroundColor = .systemBackground
        contentView.backgroundColor = nil
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        contentView.addGestureRecognizer(tap)

        contentView.addSubview(cheeseImage)
        
        titleLabel.text = "Add Recipe"
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(titleField)
        
        contentView.addSubview(tempImage)
        
        contentView.addSubview(imageURL)
        contentView.addSubview(ingredients)
        contentView.addSubview(instructions)
        contentView.addSubview(notes)
        contentView.addSubview(addBtn)
        
        applyConstraints()
    }
    
    // applying constraints to each header item
    private func applyConstraints() {
        let cheeseConstraints = [
            cheeseImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            cheeseImage.widthAnchor.constraint(equalToConstant: 40),
            cheeseImage.heightAnchor.constraint(equalToConstant: 42),
            cheeseImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cheeseImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10)
        ]
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleField.topAnchor, constant: -20)
        ]
        
        let titleConstraints = [
            titleField.widthAnchor.constraint(equalToConstant: 300),
            titleField.heightAnchor.constraint(equalToConstant: 30),
            titleField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleField.bottomAnchor.constraint(equalTo: tempImage.topAnchor, constant: -15)
        ]
        
        let tempImageConstraints = [
            tempImage.widthAnchor.constraint(equalToConstant: 250),
            tempImage.heightAnchor.constraint(equalToConstant: 250),
            tempImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempImage.bottomAnchor.constraint(equalTo: imageURL.topAnchor, constant: -15)
        ]
        
        let imageURLConstraints = [
            imageURL.widthAnchor.constraint(equalToConstant: 300),
            imageURL.heightAnchor.constraint(equalToConstant: 30),
            imageURL.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageURL.bottomAnchor.constraint(equalTo: ingredients.topAnchor, constant: -10)
        ]
        
        let ingredientsConstraints = [
            ingredients.widthAnchor.constraint(equalToConstant: 300),
            ingredients.heightAnchor.constraint(equalToConstant: 30),
            ingredients.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ingredients.bottomAnchor.constraint(equalTo: instructions.topAnchor, constant: -10)
        ]
        
        let instructionsConstraints = [
            instructions.widthAnchor.constraint(equalToConstant: 300),
            instructions.heightAnchor.constraint(equalToConstant: 30),
            instructions.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            instructions.bottomAnchor.constraint(equalTo: notes.topAnchor, constant: -10)
        ]
        
        let notesConstraints = [
            notes.widthAnchor.constraint(equalToConstant: 300),
            notes.heightAnchor.constraint(equalToConstant: 100),
            notes.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            notes.bottomAnchor.constraint(equalTo: addBtn.topAnchor, constant: -15)
        ]
        
        let addConstraints = [
            addBtn.widthAnchor.constraint(equalToConstant: 80),
            addBtn.heightAnchor.constraint(equalToConstant: 30),
            addBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(cheeseConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(tempImageConstraints)
        NSLayoutConstraint.activate(imageURLConstraints)
        NSLayoutConstraint.activate(ingredientsConstraints)
        NSLayoutConstraint.activate(instructionsConstraints)
        NSLayoutConstraint.activate(notesConstraints)
        NSLayoutConstraint.activate(addConstraints)
    }
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
