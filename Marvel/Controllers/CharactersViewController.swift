//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tableViewDataSource: CharacterTableViewDataSource?

    var collectionViewDataSource: CharacterCollectionViewDataSource?
    var collectionViewDelegate: CharacterCollectionViewDelegate?
    
    
    var characters: [Character] = []
    let service: MarvelService = MarvelServiceImpl()
    var showingAsList = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        fetchCharacters()
        
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
    
    func fetchCharacters(query: String? = nil) {
        tableView.isHidden = true
        collectionView.isHidden = true
        activityIndicator.startAnimating()
        
        service.fetchCharacters(query: query) { result in
            self.activityIndicator.stopAnimating()
            switch result {
            case .success(let characters):
                self.characters = characters
                if self.showingAsList {
                    self.showingAsList = true
                    self.tableView.isHidden = false
                    self.collectionView.isHidden = true
                    self.setupTableView(with: characters)
                } else {
                    self.showingAsList = false
                    self.collectionView.isHidden = false
                    self.tableView.isHidden = true
                    self.setupCollectionView(with: characters)
                }
            case .error(let error):
                print(error)
            }
        }
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
    
    @IBAction func showAsGrid(_ sender: UIButton) {
        self.showingAsList = false
        self.collectionView.isHidden = false
        self.tableView.isHidden = true
        self.setupCollectionView(with: characters)
    }
    
    @IBAction func showAsTable(_ sender: UIButton) {
        self.showingAsList = true
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
        self.setupTableView(with: characters)
    }

    
}
