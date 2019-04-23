//
//  CharacterCollectionViewDataSource.swift
//  Marvel
//
//  Created by Thiago Lioy on 10/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    let items: [Character]
    
    init(items: [Character], collectionView: UICollectionView) {
        self.items = items
        super.init()
        registerCells(in: collectionView)
    }
    
    private func registerCells(in collectionView: UICollectionView) {
        collectionView.register(cellType: CharacterCollectionCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: CharacterCollectionCell.self)
        let character = items[indexPath.row]
        cell.setup(character: character)
        return cell
    }
    
}
