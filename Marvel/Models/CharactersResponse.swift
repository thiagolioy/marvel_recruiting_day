//
//  CharactersResponse.swift
//  Marvel
//
//  Created by Thiago Lioy on 10/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
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
