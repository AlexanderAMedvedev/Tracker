//
//  TrackerOptionCell.swift
//  Tracker
//
//  Created by Александр Медведев on 03.12.2023.
//

import Foundation
import UIKit

final class TrackerOptionCell: UITableViewCell {
    
    static let reuseIdentifier = "trackerOptionCell"
    
    let textView: UILabel = {
        let textView = UILabel()
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .ypBlackDay
        return textView
    }()
    
    private let imageFurtherView = UIImageView(image: UIImage(named: "moveFurther"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .ypGrayBackground
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
        contentView.addSubview(imageFurtherView)
        imageFurtherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageFurtherView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageFurtherView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
