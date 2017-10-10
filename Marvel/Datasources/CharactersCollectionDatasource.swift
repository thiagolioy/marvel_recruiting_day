//
//  CharactersCollectionDatasource.swift
//  Marvel
//
//  Created by Thiago Lioy on 20/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersCollectionDatasource: NSObject, UICollectionViewDataSource {
    
    var items:[Character] = []
    
    required init(items: [Character], collectionView: UICollectionView) {
        self.items = items
        super.init()
        collectionView.register(cellType: CharacterCollectionCell.self)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CharacterCollectionCell.self)
        let character = self.items[indexPath.row]
        cell.setup(item: character)
        return cell
    }
}

class CharactersCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        return CharacterCollectionCell.size(for: width)
    }
}
