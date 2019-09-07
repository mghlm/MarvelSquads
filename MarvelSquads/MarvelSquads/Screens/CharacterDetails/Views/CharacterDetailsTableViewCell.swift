//
//  CharacterDetailsView.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class CharacterDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    static var id = "CharacterDetailsTableViewCellIdentifier"
    
    var didTapSquadButton: (() -> Void)?
    
    var characterIsInSquad: Bool! {
        didSet {
            changeButtonState()
        }
    }
    
    var character: Character! {
        didSet {
            setupUI()
        }
    }
    
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
        lbl.accessibilityIdentifier = "characterNameLabelIdentifier"
        
        return lbl
    }()
    
    lazy private var addToSquadButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(handleDidTapSquadButton), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        btn.clipsToBounds = true
        btn.accessibilityIdentifier = "addToSquadButtonIdentifier"
        
        return btn
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.accessibilityIdentifier = "characterDescriptionIdentifier"
        
        return lbl
    }()
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = Color.background.value
        [characterImageView, titleLabel, addToSquadButton, descriptionLabel].forEach { addSubview($0) }
        setupImage()
        setupLabels()
        setupConstraints()
    }
    
    private func setupLabels() {
        titleLabel.text = character.name
        descriptionLabel.text = character.description
    }
    
    private func changeButtonState() {
        let buttonTitle = characterIsInSquad ? "🔥 Fire from Squad" : "💪 Recruit to Squad"
        addToSquadButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func setupImage() {
        var unwrappedImageUrl: URL?
        if let imageUrl = character.thumbnail?.imageUrl() {
            unwrappedImageUrl = imageUrl
        } else if let imageUrl = character.imageUrl, let url = URL(string: imageUrl) {
            unwrappedImageUrl = url
        }
        if let url = unwrappedImageUrl {
            characterImageView.loadImage(with: url) {
                let imagePixelWidth = self.characterImageView.image?.size.width ?? 0
                let imagePixelHeight = self.characterImageView.image?.size.height ?? 0
                let imageHeight = (UIScreen.main.bounds.width / imagePixelWidth) * imagePixelHeight
                self.characterImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
            }
        }
    }
    
    private func setupConstraints() {
        characterImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: UIScreen.main.bounds.width)
        titleLabel.anchor(top: characterImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        addToSquadButton.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 43)
        descriptionLabel.anchor(top: addToSquadButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
    
    @objc private func handleDidTapSquadButton() {
        didTapSquadButton?()
    }
}
