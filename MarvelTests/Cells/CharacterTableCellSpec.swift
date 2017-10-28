//
//  CharacterTableCell.swift
//  MarvelTests
//
//  Created by Sérgio Igarashi on 28/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import XCTest
@testable import Marvel

class CharacterTableCellSpec: XCTestCase {
    
    var cell: CharacterTableCell?
    
    override func setUp() {
        super.setUp()
        cell = CharacterTableCell.initFromNib()
    }
    
    func testInit() {
        XCTAssertNotNil(cell)
    }
    
    func testSetupCharacterShouldSetTheCharacterInfos() {
        var spiderman = Character()
        spiderman.id = 1
        spiderman.name = "Spider Man" 
        spiderman.bio = "Peter Parker, Photographer, Joker."
        cell?.setup(character: spiderman)
        XCTAssertEqual(cell?.name.text, spiderman.name)
        XCTAssertTrue(cell?.characterDescription?.text == spiderman.bio)
    }
    
}
