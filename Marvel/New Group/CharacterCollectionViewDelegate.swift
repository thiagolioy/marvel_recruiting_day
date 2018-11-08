//
//  CharacterCollectionViewDelegate.swift
//  Marvel
//
//  Created by Thiago Lioy on 10/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: CharactersSelectionDelegate?
    let items: [Character]
    
    init(items: [Character], delegate: CharactersSelectionDelegate) {
        self.items = items
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = collectionView.bounds.size.width / numberOfCells
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = items[indexPath.item]
        delegate?.didSelect(character: character)
    }
    
}
