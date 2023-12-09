//
//  TrackerViewCell.swift
//  Tracker
//
//  Created by Александр Медведев on 05.12.2023.
//

import Foundation
import UIKit

final class TrackerViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TrackerViewCell"
    
    var timesTapped = 0
    
    let colorField: UIView = {
       let colorField = UIView()
       colorField.layer.cornerRadius = 16
       return colorField
    }()
    
    let emoji: UILabel = {
        let emoji = UILabel()
        emoji.backgroundColor = .ypGrayBackground
        emoji.layer.masksToBounds = true
        emoji.layer.cornerRadius = 16
        return emoji
    }()
    
    let trackerName: UILabel = {
        let trackerName = UILabel()
        trackerName.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        trackerName.textColor = .ypWhiteDay
        return trackerName
    }()
    
    let trackerDoneButton: UIButton = {
        let trackerDoneButton = UIButton(type: .custom)
        trackerDoneButton.setImage(UIImage(named: "plusButton"), for: .normal)
        return trackerDoneButton
    }()
    
    let trackerDaysDone: UILabel = {
        let trackerDaysDone = UILabel()
        trackerDaysDone.text = "0 дней"
        trackerDaysDone.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        trackerDaysDone.textColor = .ypBlackDay
        return trackerDaysDone
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(colorField)
        colorField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorField.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -58),
            colorField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
        trackerDoneButton.addTarget(self, action: #selector(self.didTapTrackerCellButton), for: .touchUpInside)
        contentView.addSubview(trackerDoneButton)
        trackerDoneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackerDoneButton.topAnchor.constraint(equalTo: colorField.bottomAnchor, constant: 8),
            trackerDoneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            trackerDoneButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 121),
            trackerDoneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
        
        contentView.addSubview(emoji)
        emoji.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emoji.heightAnchor.constraint(equalToConstant: 24),
            emoji.widthAnchor.constraint(equalTo: emoji.heightAnchor),
            emoji.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            emoji.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
        ])
        
        contentView.addSubview(trackerName)
        trackerName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackerName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            trackerName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            trackerName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44),
            trackerName.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -70),
            ])
        
        contentView.addSubview(trackerDaysDone)
        trackerDaysDone.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackerDaysDone.topAnchor.constraint(equalTo: colorField.bottomAnchor, constant: 16),
            trackerDaysDone.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            trackerDaysDone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            trackerDaysDone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func didTapTrackerCellButton() {
        timesTapped += 1
        if timesTapped%2 == 1 {
            trackerDoneButton.setImage(UIImage(named: "doneButton"), for: .normal)
            trackerDaysDone.text = "1 день"
        } else if timesTapped%2 == 0 {
                    trackerDoneButton.setImage(UIImage(named: "plusButton"), for: .normal)
        }
    }
}
