//
//  Character.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation

struct Character: Codable {
    var id: Int
    var name: String
    var bio: String
    var thumbImage: ThumbImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bio = "description"
        case thumbImage = "thumbnail"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(bio, forKey: .bio)
        try container.encode(thumbImage, forKey: .thumbImage)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        bio = try values.decode(String.self, forKey: .bio)
        thumbImage = try values.decode(Optional<ThumbImage>.self, forKey: .thumbImage)
    }
}
