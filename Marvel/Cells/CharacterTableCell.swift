//
//  CharacterTableCell.swift
//  Marvel
//
//  Created by filipe.n.jordao on 23/04/19.
//

import UIKit
import Keys

final class CharacterTableCell: UITableViewCell {
    static let reuseId = "CharacterTableCell"
    
    lazy var name: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var characterDescription: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var thumb: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2470588235, blue: 0.2980392157, alpha: 1)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(character: Character) {
        name.text = character.name
        characterDescription.text = character.bio.isEmpty ? "No description" : character.bio
        thumb.download(image: character.thumbImage?.fullPath() ?? "")
    }
}

extension CharacterTableCell: CodeView {
    func buildViewHierarchy() {
        [name,
         characterDescription,
         thumb].forEach(addSubview)
    }
    
    func setupConstraints() {
        thumb.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumb.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        thumb.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        thumb.heightAnchor.constraint(equalToConstant: 80).isActive = true
        thumb.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        name.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        name.leftAnchor.constraint(equalTo: thumb.rightAnchor, constant: 15).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 15).isActive = true
        name.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        characterDescription.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        characterDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8).isActive = true
        characterDescription.leftAnchor.constraint(equalTo: thumb.rightAnchor, constant: 15).isActive = true
        characterDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 15).isActive = true
        
    }
}
