//
//  CharactersView.swift
//  Marvel
//
//  Created by filipe.n.jordao on 23/04/19.
//

import UIKit

final class CharactersView: UIView {
    
    lazy  var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy  var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy  var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy  var collectionView: UICollectionView = {
        let view = UICollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharactersView: CodeView {
    func buildViewHierarchy() {
        [searchBar, tableView, collectionView, activityIndicator].forEach(addSubview)
    }
    
    func setupConstraints() {
        searchBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
