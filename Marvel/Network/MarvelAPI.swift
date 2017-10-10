//
//  MarvelAPI.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import CryptoSwift
import Keys



struct MarvelAPIConfig {
    fileprivate static let keys = MarvelKeys()
    static let privatekey = keys.marvelPrivateKey()!
    static let apikey = keys.marvelApiKey()!
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privatekey)\(apikey)".md5()
}

struct CharactersResponse: Codable {
    
    struct DataResponse: Codable  {
        var results: [Character]
        
        private enum CodingKeys: String, CodingKey {
            case results
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(results, forKey: .results)
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            results = try values.decode([Character].self, forKey: .results)
        }
    }
    
    var data: DataResponse
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode(DataResponse.self, forKey: .data)
    }
}


