//
//  ViewController.swift
//  My Netflix Clone
//
//  Created by said fatah on 21/4/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        // let vc2 = UINavigationController(rootViewController:  NormalSearchViewController())
        // inspiered by Amr's tutorial
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: UpcomingViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "play.circle") 
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down")
        
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Search"
        vc3.tabBarItem.title = "Upcoming"
        vc4.tabBarItem.title = "Downloads"

        tabBar.tintColor = .label
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }


}

