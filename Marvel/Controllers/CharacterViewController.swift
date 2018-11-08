//
//  CharacterViewController.swift
//  Marvel
//
//  Created by thiago.lioy on 08/11/18.
//  Copyright © 2018 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterViewController: UIViewController{
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterDescription: UILabel!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let character = self.character else {
            characterDescription.text = "Error on load Character"
            navigationItem.title = "Error"
            return
        }
        
        navigationItem.title = character.name
        
        characterDescription.text = character.bio.isEmpty ? "No description" : character.bio
        characterImage.download(image: character.thumbImage?.fullPath() ?? "")
    }
}
