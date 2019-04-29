//
//  CharacterTableViewDatasource.swift
//  Marvel
//
//  Created by Thiago Lioy on 10/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterTableViewDataSource: NSObject, UITableViewDataSource {
    
    let items: [Character]
    
    init(items: [Character], tableView: UITableView) {
        self.items = items
        super.init()
        setupTableView(tableView)
    }
    
    private func setupTableView(_ tableView: UITableView) {
        tableView.register(CharacterTableCell.self, forCellReuseIdentifier: CharacterTableCell.reuseId)
        tableView.rowHeight = 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableCell.reuseId) as? CharacterTableCell else { return UITableViewCell() }
        let character = items[indexPath.row]
        cell.setup(character: character)
        return cell
    }
    
}
