//
//  CharactersViewController.swift
//  MarvelTests
//
//  Created by Sérgio Igarashi on 28/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import XCTest
import UIKit
@testable import Marvel

class CharactersViewControllerSpec: XCTestCase {
    
    var sut = CharactersViewController.initFromStoryboard()
    var sutMock = CharactersViewControllerMock()
    
    override func setUp() {
        super.setUp()
        sut.loadView()
    }
    
    func testInit(){
        XCTAssertNotNil(sut)
    }
    
    func testViewDidLoadShouldConfigureTheSearchBar() {
        sutMock.viewDidLoad()
        XCTAssertTrue(sutMock.setupSearchBarCalled)
    }
    
    func testViewDidLoadShouldCallFetchCharacters() {
        sutMock.viewDidLoad()
         XCTAssertTrue(sutMock.fetchCharactersCalled)
    }
    
}
