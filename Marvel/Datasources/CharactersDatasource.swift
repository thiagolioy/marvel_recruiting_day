//
//  CharactersDatasource.swift
//  Marvel
//
//  Created by Thiago Lioy on 17/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersDatasource: NSObject, UITableViewDataSource {
    
    var items:[Character] = []
    
    required init(items: [Character], tableView: UITableView) {
        self.items = items
        super.init()
        tableView.register(cellType: CharacterTableCell.self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CharacterTableCell.self)
        let character = self.items[indexPath.row]
        cell.setup(item: character)
        return cell
    }
}
