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

        setupViewControllers()
    }
    
    func setupViewControllers() {
        let productListBuilder = ProductScreenBuilderImpl()
        let productListViewController = productListBuilder.build()
        let productListTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ProductsTabDeselectedIcon"), selectedImage: UIImage(named: "ProductsTabSelectedIcon"))
        productListViewController.tabBarItem = productListTabBarItem
        
        viewControllers = [productListViewController]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.title ?? "")
    }
}
