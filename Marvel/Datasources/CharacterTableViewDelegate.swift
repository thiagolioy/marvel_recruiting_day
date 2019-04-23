//
//  CharactersTableViewDelegate.swift
//  Marvel
//
//  Created by thiago.lioy on 08/11/18.
//  Copyright © 2018 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterTableViewDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: CharactersSelectionDelegate?
    let items: [Character]
    
    init(items: [Character], delegate: CharactersSelectionDelegate) {
        self.items = items
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = items[indexPath.item]
        delegate?.didSelect(character: character)
    }
}
