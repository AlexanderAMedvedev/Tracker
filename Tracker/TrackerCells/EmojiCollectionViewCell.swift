//
//  EmojiCollectionViewCell.swift
//  Tracker
//
//  Created by Александр Медведев on 08.12.2023.
//

import Foundation
import UIKit

final class EmojiCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "emojiCell"
    
    let emojiSymbol: UILabel = {
        let symbol = UILabel()
        symbol.translatesAutoresizingMaskIntoConstraints = false
        return symbol
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
        contentView.addSubview(emojiSymbol)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            emojiSymbol.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiSymbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
