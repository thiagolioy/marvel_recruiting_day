//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var characters: [Character] = []
    
    var showingAsList = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
       
        
        self.tableView.register(UINib(nibName: "CharacterTableCell", bundle: nil),
                                forCellReuseIdentifier: "CharacterTableCell")
        self.collectionView.register(UINib(nibName: "CharacterCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        tableView.isHidden = true
        collectionView.isHidden = true
        activityIndicator.startAnimating()
        
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
        var urlComps = URLComponents(string: endpoint)
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "apikey", value: MarvelAPIConfig.apikey),
            URLQueryItem(name: "ts", value: MarvelAPIConfig.ts),
            URLQueryItem(name: "hash", value: MarvelAPIConfig.hash)
        ]
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else {
            fatalError("Should create url")
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                fatalError("Should have a valid data")
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let responseObj = try jsonDecoder.decode(CharactersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.characters = responseObj.data.results
                    
                    if self.showingAsList {
                        self.showingAsList = true
                        self.tableView.isHidden = false
                        self.collectionView.isHidden = true
                        self.tableView.rowHeight = 80
                        self.tableView.reloadData()
                    } else {
                        self.showingAsList = false
                        self.collectionView.isHidden = false
                        self.tableView.isHidden = true
                        self.collectionView.reloadData()
                    }
                }
            } catch {
                fatalError("error: \(error)")
            }
            
        }
        
        task.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionCell", for: indexPath) as? CharacterCollectionCell
        let character = self.characters[indexPath.row]
        cell?.name.text = character.name
        cell?.thumb.download(image: character.thumbImage?.fullPath() ?? "")
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = collectionView.bounds.size.width / numberOfCells
        return CGSize(width: width, height: width)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableCell", for: indexPath)
        as? CharacterTableCell
        let character = characters[indexPath.row]
        cell?.name.text = character.name
        cell?.characterDescription.text = character.bio.isEmpty ? "No description" : character.bio
        cell?.thumb.download(image: character.thumbImage?.fullPath() ?? "")
        return cell ?? UITableViewCell()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            
            tableView.isHidden = true
            collectionView.isHidden = true
            activityIndicator.startAnimating()
            
            let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
            var urlComps = URLComponents(string: endpoint)
            
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "apikey", value: MarvelAPIConfig.apikey),
                URLQueryItem(name: "ts", value: MarvelAPIConfig.ts),
                URLQueryItem(name: "hash", value: MarvelAPIConfig.hash),
                URLQueryItem(name: "nameStartsWith", value: query)
            ]
            
            urlComps?.queryItems = queryItems
            
            guard let url = urlComps?.url else {
                fatalError("Should create url")
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    fatalError("Should have a valid data")
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let responseObj = try jsonDecoder.decode(CharactersResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.characters = responseObj.data.results
                        
                        if self.showingAsList {
                            self.showingAsList = true
                            self.tableView.isHidden = false
                            self.collectionView.isHidden = true
                            self.tableView.rowHeight = 80
                            self.tableView.reloadData()
                        } else {
                            self.showingAsList = false
                            self.collectionView.isHidden = false
                            self.tableView.isHidden = true
                            self.collectionView.reloadData()
                        }
                    }
                } catch {
                    fatalError("error: \(error)")
                }
                
            }
            
            task.resume()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    @IBAction func showAsGrid(_ sender: UIButton) {
        self.showingAsList = false
        self.collectionView.isHidden = false
        self.tableView.isHidden = true
        self.collectionView.reloadData()
    }
    
    @IBAction func showAsTable(_ sender: UIButton) {
        self.showingAsList = true
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "CharacterViewController") as? CharacterViewController else {
            fatalError("should be a controller of type CharacterViewController")
        }
        
        let character = characters[indexPath.item]
        controller.character = character
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "CharacterViewController") as? CharacterViewController else {
            fatalError("should be a controller of type CharacterViewController")
        }
        
        let character = characters[indexPath.item]
        controller.character = character
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
