//
//  SquadHeaderCollectionViewCell.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 05/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class SquadHeaderCollectionViewCell: UICollectionViewCell {
    
    var squadMember: SquadMember! {
        didSet {
            setupUI()
        }
    }
    
    static let id = "SquadHeaderCollectionViewCellIdentifier"
    
    // MARK: - Private propreties
    
    lazy private var imageView: ImageLoader = {
        let iv = ImageLoader()
        iv.layer.cornerRadius = 32
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy private var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        lbl.textColor = .white
        
        return lbl
    }()
    
    // MARK: - Private methods
    
    private func setupUI() {
        [imageView, nameLabel].forEach { addSubview($0) }
        setupImage()
        nameLabel.text = squadMember.name ?? ""
        
        setupConstraints()
    }
    
    private func setupImage() {
        if let imageUrlString = squadMember.imageUrl, let imageUrl = URL(string: imageUrlString) {
            imageView.loadImage(with: imageUrl)
        }
    }
    
    private func setupConstraints() {
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 64, height: 64)
        nameLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
