//
//  CharacterCollectionViewDelegate.swift
//  Marvel
//
//  Created by Thiago Lioy on 10/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = collectionView.bounds.size.width / numberOfCells
        return CGSize(width: width, height: width)
    }
    
}
