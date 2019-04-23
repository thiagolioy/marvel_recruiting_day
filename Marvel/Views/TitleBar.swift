//
//  TitleBar.swift
//  Marvel
//
//  Created by filipe.n.jordao on 23/04/19.
//

import UIKit

final class TitleBar: UIView {
    lazy var label: UILabel = {
        let view = UILabel()
        view.textColor = .white
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

extension TitleBar: CodeView {
    func buildViewHierarchy() {
        addSubview(label)
    }
    
    func setupConstraints() {
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 21).isActive = true
    }
}
