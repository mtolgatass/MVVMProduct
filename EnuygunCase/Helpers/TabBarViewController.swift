//
//  TabBarViewController.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .black

        setupViewControllers()
    }
    
    func setupViewControllers() {
        let productListBuilder = ProductScreenBuilderImpl()
        let productListViewController = productListBuilder.build()
        let productListDeselectedIcon = UIImage(named: "ProductsTabDeselectedIcon")?.withRenderingMode(.alwaysOriginal)
        let productListSelectedIcon = UIImage(named: "ProductsTabSelectedIcon")?.withRenderingMode(.alwaysOriginal)
        let productListTabBarItem = UITabBarItem(title: "", image: productListDeselectedIcon, selectedImage: productListSelectedIcon)
        productListViewController.tabBarItem = productListTabBarItem
        
        let favoritesBuilder = FavoritesBuilderImpl()
        let favoritesViewController = favoritesBuilder.build()
        let favoritesSelectedIcon = UIImage(named: "FavoritesTabSelectedIcon")?.withRenderingMode(.alwaysOriginal)
        let favoritesDeselectedIcon = UIImage(named: "FavoritesTabDeselectedIcon")?.withRenderingMode(.alwaysOriginal)
        let favoritesTabBarItem = UITabBarItem(title: "", image: favoritesDeselectedIcon, selectedImage: favoritesSelectedIcon)
        favoritesViewController.tabBarItem = favoritesTabBarItem
        
        viewControllers = [productListViewController, favoritesViewController]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.title ?? "")
    }
}
