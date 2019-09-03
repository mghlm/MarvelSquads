//
//  CharacterDetailsView.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class CharacterDetailsView: UIView {
    
    // MARK: - Private properties
    
    private var character: Character
    
    lazy private var characterImageView: ImageLoader = {
        let iv = ImageLoader()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.accessibilityIdentifier = "characterImageViewIdentifier"
        
        return iv
    }()
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        lbl.numberOfLines = 2
        lbl.accessibilityIdentifier = "characterDetailsTitleLabelIdentifier"
        
        return lbl
    }()
    
    lazy private var addToSquadButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        
        return btn
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.italicSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.accessibilityIdentifier = "characterDetailsDescriptionLabelIdentifier"
        
        return lbl
    }()
    
    private var comicsView: ComicsView!
    
    // MARK: - Init
    
    init(frame: CGRect, character: Character) {
        self.character = character
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        [characterImageView, titleLabel, addToSquadButton, descriptionLabel].forEach { addSubview($0) }
        setupImage()
        titleLabel.text = character.name
        let buttonTitle = character.isInSquad ? "🔥 Fire from Squad" : "💪 Recruit to Squad"
        addToSquadButton.setTitle(buttonTitle, for: .normal)
        descriptionLabel.text = character.description
//        comicsView = ComicsView(frame: .zero, comics: character)
        setupConstraints()
    }
    
    private func setupImage() {
//        if let imageData = character.image, let image = UIImage(data: imageData) {
//            posterImageView.image = image
//        } else if let imageURL = movie.getImageUrl() {
//            posterImageView.loadImage(with: imageURL)
//        }
        
        if let imageUrl = character.thumbnail.imageUrl() {
            characterImageView.loadImage(with: imageUrl)
        }
    }
    
    private func setupConstraints() {
        characterImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        titleLabel.anchor(top: characterImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        addToSquadButton.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 43)
        descriptionLabel.anchor(top: addToSquadButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
//        comicsView.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}
