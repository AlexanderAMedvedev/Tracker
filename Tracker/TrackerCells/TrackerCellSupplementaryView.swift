//
//  TrackersCellSupplementaryView.swift
//  Tracker
//
//  Created by Александр Медведев on 05.12.2023.
//

import Foundation
import UIKit

final class TrackerCellSupplementaryView: UICollectionReusableView {
    let title = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 14),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
