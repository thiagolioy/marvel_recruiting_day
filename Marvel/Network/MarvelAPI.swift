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
    static let privatekey = keys.marvelPrivateKey
    static let apikey = keys.marvelApiKey
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privatekey)\(apikey)".md5()
}

enum Result<T> {
    case success(T)
    case error(Error)
}

protocol MarvelService {
    func fetchCharacters(query: String?, callback: @escaping  (Result<[Character]>) -> Void)
}

struct GenericError: Error {
    
}

class MarvelServiceImpl: MarvelService {
  
    func fetchCharacters(query: String?, callback: @escaping (Result<[Character]>) -> Void) {
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
        var urlComps = URLComponents(string: endpoint)
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "apikey", value: MarvelAPIConfig.apikey),
            URLQueryItem(name: "ts", value: MarvelAPIConfig.ts),
            URLQueryItem(name: "hash", value: MarvelAPIConfig.hash)
        ]
        
        if let query = query {
            queryItems.append(URLQueryItem(name: "nameStartsWith", value: query))
        }
        
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else {
            callback(.error(GenericError()))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                callback(.error(GenericError()))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let responseObj = try jsonDecoder.decode(CharactersResponse.self, from: data)
                DispatchQueue.main.async {
                    callback(.success(responseObj.data.results))
                }
            } catch {
                DispatchQueue.main.async {
                    callback(.error(error))
                }
            }
            
        }
        
        task.resume()
    }
}
