//
//  ProfileViewController.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/12/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // header title "Profile Name"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    // profile image
    private let pfp: UIImageView = {
        let pfp = UIImage(named: "jerryMouse")
        
        var width: CGFloat = 100
        var height: CGFloat = 100
        
        if let image = pfp {
            width = image.size.width
            height = image.size.height
        }
        let aspectRatio = width / height
        
        let size = CGSize(width: 150 * aspectRatio, height: 150)
        let renderer = UIGraphicsImageRenderer(size: size)
        let pfpImage = renderer.image { (context) in
            pfp?.draw(in: CGRect(origin: .zero, size: size))
        }
        
        let pfpView = UIImageView(image: pfpImage)
        pfpView.translatesAutoresizingMaskIntoConstraints = false
        pfpView.backgroundColor = UIColor(rgb: 0xffa700)
        pfpView.layer.borderWidth = 1
        pfpView.layer.borderColor = UIColor.black.cgColor
        pfpView.layer.cornerRadius = pfpView.frame.height/2
        pfpView.clipsToBounds = true
        return pfpView
    }()
    
    private let contributions: UIImageView = {
        let contributionImg = UIImage(systemName: "pencil.circle")
        let contributionView = UIImageView(image: contributionImg)
        contributionView.translatesAutoresizingMaskIntoConstraints = false
        contributionView.tintColor = .label
        return contributionView
    }()
    
    private let contributionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
//        label.text = "Contributions: \(added)"
        label.text = "Contributions: \(RecipeManager.shared.recipes.count)"
        return label
    }()
    
    private let saved: UIImageView = {
        let savedImg = UIImage(systemName: "square.and.arrow.down")
        let savedView = UIImageView(image: savedImg)
        savedView.translatesAutoresizingMaskIntoConstraints = false
        savedView.tintColor = .label
        return savedView
    }()
    
    private let savedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        RecipeManager.shared.loadSaved()
        label.text = "Saved: \(RecipeManager.shared.saved.count)"
        return label
    }()
    
    private let savedFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SavedTableViewCell.self, forCellReuseIdentifier: SavedTableViewCell.identifier)
        table.backgroundColor = .systemBackground
        table.isScrollEnabled = false
        table.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: -20, right: 0)
        return table
    }()
    
    private let headerSavedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Saved:"
        return label
    }()
    
    lazy var logOffBtn: UIButton = {
        let logOff = UIButton()
        logOff.translatesAutoresizingMaskIntoConstraints = false
        logOff.setTitle("Log Off", for: .normal)
        logOff.setTitleColor(.label, for: .normal)
        logOff.backgroundColor = UIColor(rgb: 0xffa700)
        logOff.layer.cornerRadius = 8
        logOff.titleLabel?.font = .systemFont(ofSize: 15)
        logOff.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return logOff
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        isLoggedIn = false
        navigationController?.setViewControllers([LogInViewController()], animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(pfp)
        
        titleLabel.text = "Jerry Mouse"
        view.addSubview(titleLabel)
        
        view.addSubview(contributions)
        view.addSubview(contributionsLabel)
        
        view.addSubview(saved)
        view.addSubview(savedLabel)
        
        view.addSubview(headerSavedLabel)
        view.addSubview(savedFeedTable)
        
        view.addSubview(logOffBtn)
        
        savedFeedTable.delegate = self
        savedFeedTable.dataSource = self
        
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let recipeCarouselCell = savedFeedTable.cellForRow(at: IndexPath(row: 0, section: 0)) as? SavedTableViewCell {
            recipeCarouselCell.collectionView.reloadData()
        }
        contributionsLabel.text = "Contributions: \(RecipeManager.shared.recipes.count)"
        savedLabel.text = "Saved: \(RecipeManager.shared.saved.count)"
    }
    
    private func applyConstraints() {
        let pfpConstraints = [
            pfp.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            pfp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pfp.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20)
        ]
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contributions.topAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: contributionsLabel.topAnchor, constant: -22),
            titleLabel.bottomAnchor.constraint(equalTo: saved.topAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: savedLabel.topAnchor, constant: -22)
        ]
        
        let contributionsConstraints = [
            contributions.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            contributions.widthAnchor.constraint(equalToConstant: 20),
            contributions.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let contributionsLabelConstraints = [
            contributionsLabel.leadingAnchor.constraint(equalTo: contributions.trailingAnchor, constant: 5)
        ]
        
        let savedConstraints = [
            saved.trailingAnchor.constraint(equalTo: savedLabel.leadingAnchor, constant: -5),
            saved.widthAnchor.constraint(equalToConstant: 20),
            saved.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let savedLabelConstraints = [
            savedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            savedLabel.bottomAnchor.constraint(equalTo: headerSavedLabel.topAnchor, constant: -40)
        ]
        
        let headerSavedLabelConstraints = [
            headerSavedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerSavedLabel.bottomAnchor.constraint(equalTo: savedFeedTable.topAnchor, constant: -0)
        ]
        
        let tableConstraints = [
            savedFeedTable
                .centerXAnchor.constraint(equalTo: view.centerXAnchor),
            savedFeedTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedFeedTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedFeedTable.heightAnchor.constraint(equalToConstant: 200),
            savedFeedTable.bottomAnchor.constraint(equalTo: logOffBtn.topAnchor, constant: -60)
        ]
        
        let logOffConstraints = [
            logOffBtn.widthAnchor.constraint(equalToConstant: 120),
            logOffBtn.heightAnchor.constraint(equalToConstant: 30),
            logOffBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(pfpConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(contributionsConstraints)
        NSLayoutConstraint.activate(contributionsLabelConstraints)
        NSLayoutConstraint.activate(savedConstraints)
        NSLayoutConstraint.activate(savedLabelConstraints)
        NSLayoutConstraint.activate(headerSavedLabelConstraints)
        NSLayoutConstraint.activate(tableConstraints)
        NSLayoutConstraint.activate(logOffConstraints)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedTableViewCell.identifier, for: indexPath) as? SavedTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        return cell
    }
    
    // each cell has a height of 200
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

extension ProfileViewController: SavedTableViewCellDelegate {
    func savedTableViewCellDidTapCell(_ cell: SavedTableViewCell, viewModel: RecipeFullViewModel) {
        let recipeFull = RecipeFullViewController()
        recipeFull.configure(with: viewModel)
        navigationController?.pushViewController(recipeFull, animated: true)
    }
}
