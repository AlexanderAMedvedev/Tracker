//
//  ScheduleCell.swift
//  Tracker
//
//  Created by Александр Медведев on 04.12.2023.
//

import Foundation
import UIKit

final class ScheduleCell: UITableViewCell {
    static let reuseIdentifier = "CellForSchedule"
    
    lazy var textView: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .ypBlackDay
        return textView
    }()
    
    lazy var switchDay: UISwitch = {
        let switchDay = UISwitch()
        switchDay.translatesAutoresizingMaskIntoConstraints = false
        switchDay.onTintColor = .ypBlueSwitch
        switchDay.isOn = false
        return switchDay
    }()
    
    func configureScheduleCell(for indexPath: IndexPath) {
        if indexPath.row == 0   {
            contentView.layer.masksToBounds = true
            contentView.layer.cornerRadius = 16
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == 6 {
            contentView.layer.masksToBounds = true
            contentView.layer.cornerRadius = 16
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        return
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .ypGrayBackground
        contentView.addSubview(textView)
        contentView.addSubview(switchDay)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            textView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            switchDay.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            switchDay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
