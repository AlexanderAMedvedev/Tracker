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
    
    lazy var mainTitleView: UILabel = {
        let textView = UILabel()
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .ypBlackDay
        textView.text = "TextView"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var subTitleView: UILabel = {
        let subTextView = UILabel()
        subTextView.font = UIFont.systemFont(ofSize: 17)
        subTextView.textColor = .ypGray
        subTextView.translatesAutoresizingMaskIntoConstraints = false
        return subTextView
    }()
    
    lazy private var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy private var imageFurtherView: UIImageView = {
        let imageFurtherView = UIImageView(image: UIImage(named: "moveFurther"))
        imageFurtherView.translatesAutoresizingMaskIntoConstraints = false
        return imageFurtherView
    }()
    
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
        
        contentView.addSubview(titleStackView)
        titleStackView.addArrangedSubview(mainTitleView)
        titleStackView.addArrangedSubview(subTitleView)
        
        contentView.addSubview(imageFurtherView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageFurtherView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageFurtherView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
