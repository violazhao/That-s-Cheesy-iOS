//
//  ViewController.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/9/23.
//

import UIKit

// tab bar
class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        // individual tabs
        let homeBar = UINavigationController(rootViewController: HomeViewController())
        let addBar = UINavigationController(rootViewController: AddRecipeViewController())
        let searchBar = UINavigationController(rootViewController: SearchViewController())
        let profileBar = UINavigationController(rootViewController: LogInViewController())
        
        // setting icon images to each tab
        homeBar.tabBarItem.image = UIImage(systemName: "house")
        addBar.tabBarItem.image = UIImage(systemName: "plus.app")
        searchBar.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        profileBar.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        // setting titles to each tab
        homeBar.title = "Home"
        addBar.title = "Add Recipe"
        searchBar.title = "Search"
        profileBar.title = "Profile"
        
        // make tab bar items easier to see
        tabBar.tintColor = .label
        
        // setting the tabs on the tab bar
        setViewControllers([homeBar, addBar, searchBar, profileBar], animated: true)
    }


}

