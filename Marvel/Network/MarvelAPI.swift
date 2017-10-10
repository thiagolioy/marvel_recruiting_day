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

protocol MarvelService {
    func characters(query: String?, completion: @escaping ([Character]) -> Void)
}


fileprivate struct MarvelAPIConfig {
    fileprivate static let keys = MarvelKeys()
    static let privatekey = keys.marvelPrivateKey()!
    static let apikey = keys.marvelApiKey()!
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privatekey)\(apikey)".md5()
}

fileprivate struct CharactersResponse: Codable {
    
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

class MarvelServiceImpl: MarvelService {
    
    
    var authParams: [URLQueryItem] {
        return [
            URLQueryItem(name: "apikey", value: MarvelAPIConfig.apikey),
            URLQueryItem(name: "ts", value: MarvelAPIConfig.ts),
            URLQueryItem(name: "hash", value: MarvelAPIConfig.hash)
        ]
    }
    
    func characters(query: String?, completion: @escaping ([Character]) -> Void) {
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
        var urlComps = URLComponents(string: endpoint)
        
        var queryItems: [URLQueryItem] = []
        queryItems.append(contentsOf: authParams)
        if let query = query {
            let queryItem = URLQueryItem(name: "nameStartsWith", value: query)
            queryItems.append(queryItem)
        }
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
                    completion(responseObj.data.results)
                }
            } catch {
                fatalError("error: \(error)")
            }
            
        }
        
        task.resume()
        
    }
}
