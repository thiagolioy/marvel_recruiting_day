//
//  CharacterView.swift
//  Marvel
//
//  Created by filipe.n.jordao on 23/04/19.
//

import UIKit

final class CharacterView: UIView {
    lazy var titleBar: TitleBar = {
        let view = TitleBar()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var thumb: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterView: CodeView {
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
        titleBar.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
}
