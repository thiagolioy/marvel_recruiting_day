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
    var tableViewDelegate: CharacterTableViewDelegate?
    
    var collectionViewDataSource: CharacterCollectionViewDataSource?
    var collectionViewDelegate: CharacterCollectionViewDelegate?
    
    var service: MarvelService = MarvelServiceImpl()
    var characters: [Character] = []
    
    enum LoadingState {
        case loading
        case ready
    }
    
    enum PresentationState {
        case initial
        case list
        case grid
        case error
    }
    
    var loadingState: LoadingState = .ready {
        didSet {
            refreshLoading(state: loadingState)
        }
    }

    var presentationState: PresentationState = .list {
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
    
    fileprivate func refreshLoading(state: LoadingState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .ready:
            activityIndicator.stopAnimating()
        }
    }
    
    fileprivate func refreshUI(for presentationState: PresentationState) {
        switch presentationState {
        case .list:
            tableView.isHidden = false
            collectionView.isHidden = true
        case .grid:
            tableView.isHidden = true
            collectionView.isHidden = false
        case .error, .initial:
            tableView.isHidden = true
            collectionView.isHidden = true
        }
    }
}
extension CharactersViewController {
    
    func setupTableView(with items: [Character]) {
        tableViewDataSource = CharacterTableViewDataSource(items: characters,
                                                           tableView: tableView)
        tableViewDelegate = CharacterTableViewDelegate(items: characters, delegate: self)
        
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.reloadData()
    }
    
    func setupCollectionView(with items: [Character]) {
        collectionViewDataSource = CharacterCollectionViewDataSource(items: characters,

                                                                collectionView: collectionView)
        collectionViewDelegate = CharacterCollectionViewDelegate(items: characters, delegate: self)

        
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        collectionView.reloadData()
    }
}

extension CharactersViewController {
    func fetchCharacters(query: String? = nil) {
        loadingState = .loading
        service.fetchCharacters(query: query) { [weak self] result in
            self?.loadingState = .ready
            switch result {
            case .success(let characters):
                self?.handleFetch(of: characters)
            case .error:
                self?.presentationState = .error
            }
        }
    }
    
    func handleFetch(of characters: [Character]) {
        self.characters = characters
        self.setupTableView(with: characters)
        self.setupCollectionView(with: characters)
        let currentState = presentationState
        self.presentationState = currentState
    }

}

extension CharactersViewController {
    @IBAction func showAsGrid(_ sender: UIButton) {
        presentationState = .grid
    }
    
    @IBAction func showAsTable(_ sender: UIButton) {
        presentationState = .list
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

extension CharactersViewController: CharactersSelectionDelegate {
    func didSelect(character: Character) {
        let controller = CharacterViewController(character: character)
        navigationController?.pushViewController(controller, animated: true)
    }
}

