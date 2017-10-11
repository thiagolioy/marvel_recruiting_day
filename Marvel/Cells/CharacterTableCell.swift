//
//  CharacterTableCell.swift
//  Marvel
//
//  Created by Thiago Lioy on 15/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

final class CharacterTableCell: UITableViewCell, NibReusable {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    func setup(character: Character) {
        name.text = character.name
        characterDescription.text = character.bio.isEmpty ? "No description" : character.bio
        thumb.download(image: character.thumbImage?.fullPath() ?? "")
    }
}
