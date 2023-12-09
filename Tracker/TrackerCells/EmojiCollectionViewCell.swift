//
//  EmojiCollectionViewCell.swift
//  Tracker
//
//  Created by Александр Медведев on 08.12.2023.
//

import Foundation
import UIKit

final class EmojiCollectionViewCell: UICollectionViewCell {
    let symbol = UILabel()
    
   static let reuseIdentifier = "emojiCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(symbol)
        symbol.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            symbol.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            symbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
