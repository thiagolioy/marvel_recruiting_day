//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by thiago.lioy on 2/20/18.
//  Copyright © 2018 Thiago Lioy. All rights reserved.
//
import Quick
import Nimble
import Nimble_Snapshots

@testable import Marvel

class JsonHelper {
    
    func loadJson() -> Data {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "characters", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        return try! Data(contentsOf: url)
    }
    
    func decodeJson() -> [Marvel.Character] {
        let data = loadJson()
        let decoder = JSONDecoder()
        return try! decoder.decode([Marvel.Character].self, from: data)
    }

}


class MarvelServiceMock: MarvelService {
    
    let chars: [Marvel.Character]
    private let jsonHelper: JsonHelper
    
    init() {
        self.jsonHelper = JsonHelper()
        self.chars = jsonHelper.decodeJson()
    }
    
    func fetchCharacters(query: String?, callback: @escaping  (Result<[Marvel.Character]>) -> Void) {
        callback(
            .success(self.chars)
        )
    }
}


class CharactersViewControllerSpec: QuickSpec {
    override func spec() {
        describe("CharactersViewController") {
            
            var sut: CharactersViewController!
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nav = storyboard.instantiateInitialViewController() as! UINavigationController
                
                sut = nav.topViewController as! CharactersViewController
                sut.service = MarvelServiceMock()
                
                _ = sut.view
            }
            
            
            it("should have a valid instance") {
                expect(sut).toNot(beNil())
            }
            
            it("should have the expected number of characters") {
                expect(sut.characters.count).to(equal(6))
            }
            
            describe("CharactersViewController UI") {
                it("should have the expected loading ui") {
                    sut.presentationState = .loading
                    expect(sut.view) == snapshot("Loading State")
                }
                
                it("should have the expected list ui") {
                    sut.presentationState = .list(sut.characters)
                    expect(sut.view) == snapshot("List State")
                }
                
                it("should have the expected grid ui") {
                    sut.presentationState = .grid(sut.characters)
                    expect(sut.view) == snapshot("Grid State")
                }
                
                it("should have the expected error ui") {
                    sut.presentationState = .error
                    expect(sut.view) == snapshot("Error State")
                }
            }
            
        }
    }
}


