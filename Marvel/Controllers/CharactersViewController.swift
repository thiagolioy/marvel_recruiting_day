//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController {
    let charactersView = CharactersView()
    
    var tableViewDataSource: CharacterTableViewDataSource?
    var tableViewDelegate: CharacterTableViewDelegate?
    
    var collectionViewDataSource: CharacterCollectionViewDataSource?
    var collectionViewDelegate: CharacterCollectionViewDelegate?
    
    let service: MarvelService = MarvelServiceImpl()
    var characters: [Character] = []
    
    fileprivate var loadingState: CharactersView.LoadingState = .ready {
        didSet {
            charactersView.refreshLoading(state: loadingState)
        }
    }

    fileprivate var presentationState: CharactersView.PresentationState = .list {
        didSet {
            charactersView.refreshUI(for: presentationState)
        }
    }
}

extension CharactersViewController {
    override func loadView() {
        view = charactersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel"
        setupNavBar()
        setupSearchBar()
        fetchCharacters()
    }
}

extension CharactersViewController {
    fileprivate func setupNavBar() {
        let buttons = navBarButtons()
        navigationItem.rightBarButtonItems = buttons
    }
    
    fileprivate func navBarButtons() -> [UIBarButtonItem] {
        let gridImage = #imageLiteral(resourceName: "Grid Icon")
        let listImage = #imageLiteral(resourceName: "List Icon")
        
        let gridButton = UIBarButtonItem(image: gridImage, style: .plain, target: self, action: #selector(showAsGrid))
        let listButton = UIBarButtonItem(image: listImage, style: .plain, target: self, action: #selector(showAsTable))
        
        return [listButton, gridButton]
    }
}

extension CharactersViewController {
    
    func setupTableView(with items: [Character]) {
        let tableView = charactersView.tableView
        
        tableViewDataSource = CharacterTableViewDataSource(items: characters,
                                                           tableView: tableView)
        tableViewDelegate = CharacterTableViewDelegate(items: characters, delegate: self)
        
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.reloadData()
    }
    
    func setupCollectionView(with items: [Character]) {
        let collectionView = charactersView.collectionView
        
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
    @objc func showAsGrid(_ sender: UIButton) {
        presentationState = .grid
    }
    
    @objc func showAsTable(_ sender: UIButton) {
        presentationState = .list
    }
}


extension CharactersViewController: UISearchBarDelegate {
    func setupSearchBar() {
        charactersView.searchBar.delegate = self
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

