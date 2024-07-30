//
//  TabBarViewController.swift
//  QPLtest
//
//  Created by Bender on 23.07.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    private let mainVC = ViewController()
    private let matchesVC = MatchesViewController()
    private let favouritesVC = FavouritesViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        mainVC.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "house.fill"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        matchesVC.tabBarItem = UITabBarItem(
            title: "Матчи",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet")
        )
        
//        favouritesVC.tabBarItem = UITabBarItem(
//            title: "Favourites",
//            image: UIImage(systemName: "star.fill"),
//            selectedImage: UIImage(systemName: "star.fill") 
//        )
        
        setViewControllers([mainVC, matchesVC], animated: true)
    }
}

