//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController {
    var apiManager: MarvelService = MarvelServiceImpl()
    
    var tableDatasource: CharactersDatasource?
    
    var collectionDatasource: CharactersCollectionDatasource?
    var collectionDelegate: CharactersCollectionDelegate?
    
    var characters: [Character] = []
    
    var showingAsList = true
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension CharactersViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        fetchCharacters()
    }
}

extension CharactersViewController {
    func fetchCharacters(for query: String? = nil) {
        tableView.isHidden = true
        collectionView.isHidden = true
        activityIndicator.startAnimating()
        apiManager.characters(query: query) { characters in
            self.activityIndicator.stopAnimating()
            if self.showingAsList {
                self.setupTableView(with: characters)
            } else {
                self.setupCollectionView(with: characters)
            }
        }
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    func setupTableView(with characters: [Character]) {
        self.characters = characters
        showingAsList = true
        tableView.isHidden = false
        collectionView.isHidden = true
        tableView.rowHeight = 80
        tableDatasource = CharactersDatasource(items: characters, tableView: self.tableView)
        tableView.dataSource = tableDatasource
        tableView.reloadData()
    }
    
    func setupCollectionView(with characters: [Character]) {
        self.characters = characters
        showingAsList = false
        collectionView.isHidden = false
        tableView.isHidden = true
        collectionDelegate = CharactersCollectionDelegate()
        collectionDatasource = CharactersCollectionDatasource(items: characters, collectionView: self.collectionView)
        collectionView.dataSource = collectionDatasource
        collectionView.delegate = collectionDelegate
        collectionView.reloadData()
    }
}

extension CharactersViewController {
    @IBAction func showAsGrid(_ sender: UIButton) {
        setupCollectionView(with: characters)
    }
    
    @IBAction func showAsTable(_ sender: UIButton) {
        setupTableView(with: characters)
    }
}

extension CharactersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            fetchCharacters(for: query)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

