//
//  ViliansViewController.swift
//  Marvel
//
//  Created by Jonas Tomaz on 25/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

class ViliansViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var collectionViewDataSource: CharacterCollectionViewDataSource?
    var collectionViewDelegate: CharacterCollectionViewDelegate?

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
                collectionView.isHidden = true
            case .ready:
                activityIndicator.stopAnimating()
                collectionView.isHidden = false
            }
        }
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
        loadingState = .loading
        service.fetchCharacters(query: query) { result in
            self.loadingState = .ready
            switch result {
            case .success(let characters):
                self.characters = characters
                self.setupCollectionView(with: characters)
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
