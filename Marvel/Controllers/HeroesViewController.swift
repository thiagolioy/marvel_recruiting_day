//
//  HeroesViewController.swift
//  Marvel
//
//  Created by Jonas Tomaz on 25/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

class HeroesViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewDataSource: CharacterTableViewDataSource?
    
    let service: MarvelService = MarvelServiceImpl()
    var characters: [Character] = []
    
    fileprivate enum LoadingState {
        case loading
        case ready
    }
    
    fileprivate var loadingState: LoadingState = .ready {
        didSet {
            switch loadingState {
            case .loading:
                activityIndicator.startAnimating()
                tableView.isHidden = true
            case .ready:
                activityIndicator.stopAnimating()
                tableView.isHidden = false
            }
        }
    }
    
    func setupTableView(with items: [Character]) {
        tableViewDataSource = CharacterTableViewDataSource(items: characters,
                                                           tableView: tableView)
        tableView.dataSource = tableViewDataSource
        tableView.reloadData()
    }
    
    func fetchCharacters(query: String? = nil) {
        loadingState = .loading
        service.fetchCharacters(query: query) { result in
            self.loadingState = .ready
            switch result {
            case .success(let characters):
                self.characters = characters
                self.setupTableView(with: characters)
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }
}
