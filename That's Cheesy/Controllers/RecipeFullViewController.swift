//
//  RecipeFullViewController.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/13/23.
//

import UIKit
import CoreData

class RecipeFullViewController: UIViewController {
    var imageURL = ""
    var savedBool = false
    var recipeId = NSManagedObjectID()
    
    // recipe name
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
    
    private let recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true // prevents poster from overflowing container
        return imageView
    }()
    
    private let ingredients: UILabel = {
        let ingredients = UILabel()
        ingredients.translatesAutoresizingMaskIntoConstraints = false
        ingredients.numberOfLines = 0
        return ingredients
    }()
    
    private let instructions: UILabel = {
        let instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.numberOfLines = 0
        return instructions
    }()
    
    private let notes: UILabel = {
        let notes = UILabel()
        notes.translatesAutoresizingMaskIntoConstraints = false
        notes.numberOfLines = 0
        return notes
    }()
    
    lazy var saveBtn: UIButton = {
        let save = UIButton()
        save.translatesAutoresizingMaskIntoConstraints = false
        save.setTitleColor(.label, for: .normal)
        save.backgroundColor = UIColor(rgb: 0xffa700)
        save.layer.cornerRadius = 8
        save.titleLabel?.font = .systemFont(ofSize: 15)
        save.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return save
    }()
    
    lazy var deleteBtn: UIButton = {
        let delete = UIButton()
        delete.translatesAutoresizingMaskIntoConstraints = false
        delete.setTitleColor(.label, for: .normal)
        delete.backgroundColor = UIColor(rgb: 0xffa700)
        delete.layer.cornerRadius = 8
        delete.titleLabel?.font = .systemFont(ofSize: 15)
        delete.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        delete.setTitle("Delete", for: .normal)
        return delete
    }()
    
    @objc func deleteButtonAction(sender: UIButton!) {
        RecipeManager().deleteRecipe(id: recipeId)
    }
    
    @objc func saveButtonAction(sender: UIButton!) {
        if savedBool == false {
            RecipeManager().addSaved(id: recipeId, saved: true)
            saveBtn.setTitle("Unsave", for: .normal)
        } else {
            RecipeManager().addSaved(id: recipeId, saved: false)
            saveBtn.setTitle("Save", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        view.addSubview(cheeseImage)
        
        view.addSubview(titleLabel)
        view.addSubview(recipeImage)
        view.addSubview(ingredients)
        view.addSubview(instructions)
        view.addSubview(notes)
        if isLoggedIn == true {
            view.addSubview(saveBtn)
        } else {
            view.addSubview(deleteBtn)
        }
        
        applyConstraints()
    }
    

    // applying constraints to each header item
    private func applyConstraints() {
        let cheeseConstraints = [
            cheeseImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            cheeseImage.widthAnchor.constraint(equalToConstant: 40),
            cheeseImage.heightAnchor.constraint(equalToConstant: 42),
            cheeseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cheeseImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10)
        ]
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: recipeImage.topAnchor, constant: -20)
        ]
        
        let recipeImageConstraints = [
            recipeImage.widthAnchor.constraint(equalToConstant: 250),
            recipeImage.heightAnchor.constraint(equalToConstant: 300),
            recipeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: ingredients.topAnchor, constant: -30)
        ]
        
        let ingredientsConstraints = [
            ingredients.widthAnchor.constraint(equalToConstant: 250),
            ingredients.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ingredients.bottomAnchor.constraint(equalTo: instructions.topAnchor, constant: -20)
        ]
        
        let instructionsConstraints = [
            instructions.widthAnchor.constraint(equalToConstant: 250),
            instructions.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructions.bottomAnchor.constraint(equalTo: notes.topAnchor, constant: -20)
        ]
        
        var notesConstraints = [
            notes.widthAnchor.constraint(equalToConstant: 250),
            notes.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        var saveConstraints = [NSLayoutConstraint]()
        var deleteConstraints = [NSLayoutConstraint]()
        
        if isLoggedIn == true {
            notesConstraints.append(notes.bottomAnchor.constraint(equalTo: saveBtn.topAnchor, constant: -30))
            saveConstraints.append(saveBtn.widthAnchor.constraint(equalToConstant: 80))
            saveConstraints.append(saveBtn.heightAnchor.constraint(equalToConstant: 30))
            saveConstraints.append(saveBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        } else {
            notesConstraints.append(notes.bottomAnchor.constraint(equalTo: deleteBtn.topAnchor, constant: -30))
            deleteConstraints.append(deleteBtn.widthAnchor.constraint(equalToConstant: 80))
            deleteConstraints.append(deleteBtn.heightAnchor.constraint(equalToConstant: 30))
            deleteConstraints.append(deleteBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        }
        
        NSLayoutConstraint.activate(cheeseConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(recipeImageConstraints)
        NSLayoutConstraint.activate(ingredientsConstraints)
        NSLayoutConstraint.activate(instructionsConstraints)
        NSLayoutConstraint.activate(notesConstraints)
        if isLoggedIn == true {
            NSLayoutConstraint.activate(saveConstraints)
        } else {
            NSLayoutConstraint.activate(deleteConstraints)
        }
    }
    
    func configure(with model: RecipeFullViewModel) {
        titleLabel.text = model.recipeName
        ingredients.text = "Ingredients: \(model.ingredients)"
        instructions.text = "Instructions: \(model.instructions)"
        notes.text = "Notes: \(model.notes ?? "N/A")"
        if model.saved == true {
            savedBool = true
            saveBtn.setTitle("Unsave", for: .normal)
        } else {
            savedBool = false
            saveBtn.setTitle("Save", for: .normal)
        }
        
        let modelImage = model.image
        imageURL = "\(modelImage ?? "")"
        let url = URL(string: "\(modelImage ?? "")")
        recipeImage.sd_setImage(with: url, placeholderImage: UIImage(named: "imgCooking"), completed: nil)
        if let modelId = model.id {
            recipeId = modelId
        }
    }
}
