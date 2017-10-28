//
//  CharactersViewControllerMock.swift
//  MarvelTests
//
//  Created by Sérgio Igarashi on 28/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

@testable import Marvel

class CharactersViewControllerMock: CharactersViewController {

    var setupSearchBarCalled = false
    var fetchCharactersCalled = false
    
    func initMock() {
        setupSearchBarCalled = false
        fetchCharactersCalled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupSearchBar() {
        self.setupSearchBarCalled = true
    }
    
    override func fetchCharacters(query: String?) {
        self.fetchCharactersCalled = true
    }
    
}
