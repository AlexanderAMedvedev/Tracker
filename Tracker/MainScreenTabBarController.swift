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
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: self.tabBar.frame.size.width, height: 1)
            topBorder.backgroundColor = UIColor.gray.cgColor // Set the color of the border here
        self.tabBar.layer.addSublayer(topBorder)

    }
}

