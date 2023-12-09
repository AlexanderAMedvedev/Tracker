//
//  ViewController.swift
//  Tracker
//
//  Created by Александр Медведев on 23.11.2023.
//

import UIKit

class MainScreen: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let trackers = TrackersViewController()
        trackers.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "trackerForTabBar"),
            selectedImage: nil
        )
        let navCon = UINavigationController(rootViewController: trackers)
        
        
        let statistics = StatisticsViewController()
        statistics.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "hare"),
            selectedImage: nil
        )
        
        self.setViewControllers([navCon, statistics], animated: false)
    }
}

