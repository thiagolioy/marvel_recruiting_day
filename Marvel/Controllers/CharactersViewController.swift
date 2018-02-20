//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tableViewDataSource: CharacterTableViewDataSource?

    var collectionViewDataSource: CharacterCollectionViewDataSource?
    var collectionViewDelegate: CharacterCollectionViewDelegate?
    
    var service: MarvelService = MarvelServiceImpl()
    var characters: [Character] = []
    
    
    enum PresentationState {
        case loading
        case list([Character])
        case grid([Character])
        case error
    }
    
    enum UserSelection {
        case grid, list
    }
    
    var userSelection: UserSelection = .list
    
    var presentationState: PresentationState = .loading {
        didSet {
            refreshUI(for: presentationState)
        }
        
    }
}

extension CharactersViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        fetchCharacters()
    }
}

extension CharactersViewController {
    fileprivate func refreshUI(for presentationState: PresentationState) {
        switch presentationState {
        case .loading:
            activityIndicator.startAnimating()
            tableView.isHidden = true
            collectionView.isHidden = true
        case .list(let chars):
            userSelection = .list
            activityIndicator.stopAnimating()
            setupTableView(with: chars)
            tableView.isHidden = false
            collectionView.isHidden = true
            
        case .grid(let chars):
            userSelection = .grid
            activityIndicator.stopAnimating()
            setupCollectionView(with: chars)
            tableView.isHidden = true
            collectionView.isHidden = false
        case .error:
            activityIndicator.stopAnimating()
            tableView.isHidden = true
            collectionView.isHidden = true
        }
    }
    
    func setupTableView(with items: [Character]) {
        tableViewDataSource = CharacterTableViewDataSource(items: characters,
                                                           tableView: tableView)
        tableView.dataSource = tableViewDataSource
        tableView.reloadData()
    }
    
    func setupCollectionView(with items: [Character]) {
        collectionViewDataSource = CharacterCollectionViewDataSource(items: characters,
                                                                     collectionView: collectionView)
        collectionViewDelegate = CharacterCollectionViewDelegate()
        
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        collectionView.reloadData()
    }
}

extension CharactersViewController {
    
    func fetchCharacters(query: String? = nil) {
        presentationState = .loading
        service.fetchCharacters(query: query) { result in
            switch result {
            case .success(let characters):
                self.handle(characters: characters)
            case .error:
                self.presentationState = .error
            }
        }
    }

    func handle(characters: [Character]) {
        self.characters = characters
        if userSelection == .list {
            presentationState = .list(characters)
        } else {
            presentationState = .grid(characters)
        }
    }
}

extension CharactersViewController {
    @IBAction func showAsGrid(_ sender: UIButton) {
        presentationState = .grid(characters)
    }
    
    @IBAction func showAsTable(_ sender: UIButton) {
        presentationState = .list(characters)
    }
}


extension CharactersViewController: UISearchBarDelegate {
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            fetchCharacters(query: query)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

