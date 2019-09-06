//
//  CharacterTableViewCell.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    
    static var id = "CharacterTableViewCellIdentifier"
    
    // MARK: - Public properties
    
    var character: Character! {
        didSet {
            setupUI()
        }
    }
    
    // MARK: - Private properties
    
    lazy private var containerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = Color.cell.value
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    lazy private var characterImageView: ImageLoader = {
        let iv = ImageLoader()
        iv.layer.cornerRadius = 22
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        return lbl
    }()
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(containerView)
        [characterImageView, titleLabel].forEach { containerView.addSubview($0) }
        setupImage()
        titleLabel.text = character.name
        
        setupConstraints()
    }
    
    private func setupImage() {
        if let imageUrl = character.thumbnail?.imageUrl() {
            characterImageView.loadImage(with: imageUrl)
        }
    }
    
    private func setupConstraints() {
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        characterImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 0, width: 44, height: 44)
        titleLabel.anchor(top: containerView.topAnchor, left: characterImageView.rightAnchor, bottom: containerView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
}
