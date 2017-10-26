//
//  MarvelTableViewDatasource.swift
//  Marvel
//
//  Created by Jonas Tomaz on 25/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

class MarvelTableViewDatasource: NSObject , UITableViewDataSource{
    let items: [Character]
    
    init(items: [Character], tableView: UITableView) {
        self.items = items
        super.init()
        setupTableView(tableView)
    }
    
    private func setupTableView(_ tableView: UITableView) {
        tableView.register(cellType: MarvelTableViewCell.self)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath,
                                                 cellType: MarvelTableViewCell.self)
        let character = items[indexPath.row]
        cell.setup(character: character)
        return cell
    }
}
