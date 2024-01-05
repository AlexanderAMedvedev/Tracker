//
//  ColorCollectionViewCell.swift
//  Tracker
//
//  Created by Александр Медведев on 27.12.2023.
//

import Foundation
import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "colorCell"
    
    let colorSymbol: UIView = {
        let colorSymbol = UIView()
        colorSymbol.layer.cornerRadius = 8
        colorSymbol.translatesAutoresizingMaskIntoConstraints = false
        return colorSymbol
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(colorSymbol)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            colorSymbol.widthAnchor.constraint(equalToConstant: 40),
            colorSymbol.heightAnchor.constraint(equalToConstant: 40),
            colorSymbol.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorSymbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

