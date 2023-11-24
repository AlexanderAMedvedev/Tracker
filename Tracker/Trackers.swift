//
//  Trackers.swift
//  Tracker
//
//  Created by Александр Медведев on 23.11.2023.
//

import Foundation
import UIKit

final class Trackers: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem?.tintColor = .ypBlackDay
        
        addHeader()
        addStub()
    }
    
    @objc private func addTapped() {
        print("Tapped")
    }
    
    private func addHeader()  {
        let header = UILabel()
        header.text = "Трекеры"
        header.font = UIFont.boldSystemFont(ofSize: 34)
        header.textColor = .ypBlackDay
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        return
    }
    private func addStub() {
        let image = UIImage(named: "trackerStub")
        let stubPicture = UIImageView(image: image)
        stubPicture.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stubPicture)
        NSLayoutConstraint.activate([
            stubPicture.heightAnchor.constraint(equalToConstant: 80),
            stubPicture.widthAnchor.constraint(equalToConstant: 80),
            stubPicture.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stubPicture.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 147)
        ])
    
        let stubText = UILabel()
        stubText.text = "Что будем отслеживать?"
        stubText.font = UIFont.systemFont(ofSize: 12)
        stubText.textColor = .ypBlackDay
        stubText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stubText)
        NSLayoutConstraint.activate([
            stubText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stubText.topAnchor.constraint(equalTo: stubPicture.bottomAnchor, constant: 8)
            ])
    }
}
