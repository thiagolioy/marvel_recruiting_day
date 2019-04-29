//
//  CharacterCollectionCell.swift
//  Marvel
//
//  Created by filipe.n.jordao on 23/04/19.
//

import UIKit
import Reusable

final class CharacterCollectionCell: UICollectionViewCell, Reusable {
    lazy var titleBar: TitleBar = {
        let view = TitleBar()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var thumb: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setup(character: Character) {
        titleBar.label.text = character.name
        thumb.download(image: character.thumbImage?.fullPath() ?? "")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterCollectionCell: CodeView {
    func buildViewHierarchy() {
        [thumb, titleBar].forEach(addSubview)
    }
    
    func setupConstraints() {
        thumb.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumb.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        thumb.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        thumb.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        titleBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleBar.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleBar.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        titleBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
