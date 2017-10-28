//
//  CharacterTableViewDatasourceSpec.swift
//  MarvelTests
//
//  Created by Sérgio Igarashi on 27/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import XCTest
@testable import Marvel

class CharacterTableViewDatasourceSpec: XCTestCase {
    
    var sut: CharacterTableViewDataSource?
    var avengers: [Marvel.Character] = []
    var fakeTableView = UITableView(frame: .zero)
    
    override func setUp() {
        super.setUp()
        let spiderman = Character()
        let hulk = Character()
        let thor = Character()
        let ironman = Character()
        avengers = [spiderman, hulk, thor, ironman]
        sut = CharacterTableViewDataSource(items: avengers, tableView: fakeTableView)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testInit(){
        XCTAssertNotNil(sut)
    }
    
    func testInitShouldSetTheTableViewHeight(){
        XCTAssertEqual(fakeTableView.rowHeight, 80)
    }
    
    func testNumberOfRowsShouldReturnTheArrayCount(){
        XCTAssertEqual(avengers.count, sut?.tableView(fakeTableView, numberOfRowsInSection: 0))
    }
    
    func testCellForRowShouldReturnAConfiguredCell(){
        let cell = sut?.tableView(fakeTableView, cellForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell)
        XCTAssertTrue(cell!.isKind(of: CharacterTableCell.self))
    }
    
    
}
