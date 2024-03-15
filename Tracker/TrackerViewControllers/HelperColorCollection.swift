//
//  HelperColorCollection.swift
//  Tracker
//
//  Created by Александр Медведев on 27.12.2023.
//

import Foundation
import UIKit

final class HelperColorCollection: NSObject, UICollectionViewDataSource {
    
    weak var delegate: NewHabitOrEventViewController?
    
    init(delegate: NewHabitOrEventViewController) {
        self.delegate = delegate
    }
    
    let reuseIdentifier = "colorCell"
    
    let colors: [UIColor] = [.ypColor_1, .ypColor_2, .ypColor_3, .ypColor_4, .ypColor_5, .ypColor_6, .ypColor_7, .ypColor_8, .ypColor_9, .ypColor_10, .ypColor_11, .ypColor_12, .ypColor_13, .ypColor_14, .ypColor_15, .ypColor_16, .ypColor_17, .ypColor_18]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.reuseIdentifier, for: indexPath)
        guard let cell = (cell as? ColorCollectionViewCell) else {
            print("Cell of the needed type was not created")
            return UICollectionViewCell()
        }
        cell.colorSymbol.backgroundColor = colors[indexPath.row]
        return cell
    }
}

extension HelperColorCollection: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 52, height: 52)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = (collectionView.cellForItem(at: indexPath) as! ColorCollectionViewCell)
        
        cell.layer.masksToBounds = true
        let borderWidth: CGFloat = 3.0
        cell.layer.borderColor = colors[indexPath.row].cgColor
        cell.layer.cornerRadius = 16
        cell.layer.borderWidth = borderWidth
        
        delegate?.color = colors[indexPath.row]
        delegate?.makeCreateButtonActive()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = (collectionView.cellForItem(at: indexPath) as! ColorCollectionViewCell)
        cell.layer.borderWidth = 0.0
    }
    
}
