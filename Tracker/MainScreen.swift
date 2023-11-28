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

    private func addLogoView() {
        let logoView = UIImageView(image: UIImage(named: "Logo"))
        logoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoView)
        NSLayoutConstraint.activate([
            logoView.heightAnchor.constraint(equalToConstant: 77.68),
            logoView.widthAnchor.constraint(equalToConstant: 75),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

