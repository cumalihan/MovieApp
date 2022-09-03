//
//  TabBarController.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 1.09.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
        viewControllers = [createMovieNC(),createFavoritesNC()]
        
    }
    
    func createMovieNC() -> UINavigationController {
        let upComingVC = MovieListViewController()
        upComingVC.title = "Movie"
        upComingVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        
        return UINavigationController(rootViewController: upComingVC)
    }
    
    func createFavoritesNC() -> UINavigationController{
        let favoritesNC = ViewController()
        favoritesNC.title = "Favorites"
        favoritesNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesNC)
    }

}
