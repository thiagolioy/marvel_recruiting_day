//
//  MarvelTableViewCell.swift
//  Marvel
//
//  Created by Jonas Tomaz on 25/10/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

class MarvelTableViewCell: UITableViewCell,Reusable {
    
    lazy var thumb: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var characterName: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.numberOfLines = 0
        lb.textColor = ColorPalette.white
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var characterDescription: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.numberOfLines = 0
        lb.textColor = ColorPalette.white
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(character: Character) {
        characterName.text = character.name
        characterDescription.text = character.bio.isEmpty ? "No description" : character.bio
        thumb.download(image: character.thumbImage?.fullPath() ?? "")
    }
    
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}

extension MarvelTableViewCell {
    func buildViewHierarchy() {
        self.addSubview(self.thumb)
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.characterName)
        self.containerView.addSubview(self.characterDescription)
    }
    
    func setupConstraints() {
        let views = ["thumb":thumb,
                     "container":containerView,
                     "name":characterName,
                     "description":characterDescription]
        
        let metrics = ["defaultMargin":0,
                       "customMargin":15,
                       "thumbDimention":100]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let thumbVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-defaultMargin-[thumb(thumbDimention)]->=defaultMargin-|",
            options: .alignAllTop,
            metrics: metrics,
            views: views)

        allConstraints += thumbVerticalConstraints
        let thumbHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-defaultMargin-[thumb(thumbDimention)]-customMargin-[container]-customMargin-|",
            options: [],
            metrics: metrics,
            views: views)

        allConstraints += thumbHorizontalConstraints
        
        let containerVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-defaultMargin-[container]-defaultMargin-|",
            options: .alignAllTop,
            metrics: metrics,
            views: views)

        allConstraints += containerVerticalConstraints
        let nameHorrizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-defaultMargin-[name]-defaultMargin-|",
            options: [],
            metrics: metrics,
            views: views)

        allConstraints += nameHorrizontalConstraints
        let descriptionHorrizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-defaultMargin-[description]-defaultMargin-|",
            options: [],
            metrics: metrics,
            views: views)

        allConstraints += descriptionHorrizontalConstraints

        let nameVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-customMargin-[name]-defaultMargin-[description]-customMargin-|",
            options: [],
            metrics: metrics,
            views: views)

        allConstraints += nameVerticalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    func configureViews() {
        self.contentView.backgroundColor = UIColor.black
        self.selectionStyle = .none
    }
}
