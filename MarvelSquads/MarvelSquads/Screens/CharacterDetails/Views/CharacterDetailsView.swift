//
//  CharacterDetailsView.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class CharacterDetailsView: UIView {
    
//    var didLoadCharacterImage: (() -> Void)?
    
    // MARK: - Private properties
    
    var didLoadView: (() -> Void)?
    
    private var character: Character
    
    var comics: [Comic]? {
        didSet {
            comicsView.comics = comics 
        }
    }
    
    lazy private var contentView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = Color.background.value
        return v
    }()
    
    lazy private var characterImageView: ImageLoader = {
        let iv = ImageLoader()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.accessibilityIdentifier = "characterImageViewIdentifier"
        
        return iv
    }()
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 34)
        lbl.textColor = .white
        lbl.numberOfLines = 2
        lbl.accessibilityIdentifier = "characterDetailsTitleLabelIdentifier"
        
        return lbl
    }()
    
    lazy private var addToSquadButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        btn.clipsToBounds = true
        
        return btn
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.accessibilityIdentifier = "characterDetailsDescriptionLabelIdentifier"
        
        return lbl
    }()
    
    lazy private var comicsView: ComicsView = {
        let cv = ComicsView(frame: .zero)
        return cv
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, character: Character) {
        self.character = character
        super.init(frame: frame)
        
        setupCallbacks()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = Color.background.value
        addSubview(contentView)
        contentView.fillSuperview()
        [characterImageView, titleLabel, addToSquadButton, descriptionLabel, comicsView].forEach { contentView.addSubview($0) }
        
        setupImage()
        setupLabels()
        setupConstraints()
    }
    
    private func setupCallbacks() {
        comicsView.didLoadComics = { [weak self] in
            self?.didLoadView?()
        }
    }
    
    private func setupLabels() {
        titleLabel.text = character.name
        let buttonTitle = character.isInSquad ? "🔥 Fire from Squad" : "💪 Recruit to Squad"
        addToSquadButton.setTitle(buttonTitle, for: .normal)
        descriptionLabel.text = character.description
    }
    
    private func setupImage() {
//        if let imageData = character.image, let image = UIImage(data: imageData) {
//            posterImageView.image = image
//        } else if let imageURL = movie.getImageUrl() {
//            posterImageView.loadImage(with: imageURL)
//        }
        
        if let imageUrl = character.thumbnail.imageUrl() {
            characterImageView.loadImage(with: imageUrl) {
                let imagePixelWidth = self.characterImageView.image?.size.width ?? 0
                let imagePixelHeight = self.characterImageView.image?.size.height ?? 0
                let imageHeight = (UIScreen.main.bounds.width / imagePixelWidth) * imagePixelHeight

                self.characterImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
//                self.didLoadCharacterImage?()
            }
        }
    }
    
    private func setupConstraints() {
        characterImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: UIScreen.main.bounds.width)
        titleLabel.anchor(top: characterImageView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 24, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        addToSquadButton.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 43)
        descriptionLabel.anchor(top: addToSquadButton.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        comicsView.anchor(top: descriptionLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}
