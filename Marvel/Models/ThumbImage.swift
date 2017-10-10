//
//  ThumbImage.swift
//  Marvel
//
//  Created by Thiago Lioy on 17/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation

struct ThumbImage: Codable {
    var path: String
    var imageExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
    
    func fullPath() -> String {
        return "\(path).\(imageExtension)"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(path, forKey: .path)
        try container.encode(imageExtension, forKey: .imageExtension)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decode(String.self, forKey: .path)
        imageExtension = try values.decode(String.self, forKey: .imageExtension)
    }
    
}
