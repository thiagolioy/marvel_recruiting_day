//
//  CharacterViewController.swift
//  Marvel
//
//  Created by thiago.lioy on 08/11/18.
//  Copyright © 2018 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

final class CharacterViewController: UIViewController {
    let character: Character
    let characterView = CharacterView()
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = characterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        navigationItem.title = character.name
        
        characterView.titleBar.label.text = character.bio.isEmpty ? "No description" : character.bio
        characterView.thumb.download(image: character.thumbImage?.fullPath() ?? "")
    }
}
