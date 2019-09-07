//
//  ComicsView.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class ComicsTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    static var id = "ComicsTableViewCellIdentifier"
    
    var comics: [Comic]! {
        didSet {
            setupUI()
        }
    }
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lbl.textColor = .white 
        lbl.text = "Last appeared in"
        lbl.accessibilityIdentifier = "comicsTitleLabelIdentifier"
        
        return lbl
    }()
    
    lazy private var firstImageView: ImageLoader = {
        let iv = ImageLoader()
        return iv
    }()
    
    lazy private var secondImageView: ImageLoader = {
        let iv = ImageLoader()
        return iv
    }()
    
    lazy private var firstTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    lazy private var secondTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    lazy private var thumbNailStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 16
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.accessibilityIdentifier = "comicsStackViewIdentifier"
        
        return sv
    }()
    
    lazy private var titlesStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 16
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.accessibilityIdentifier = "comicsTitlesStackViewIdentifier"
        
        return sv
    }()
    
    private var otherComicsLabel: UILabel?
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = Color.background.value
        setupTitleLabel()
        [thumbNailStackView, titlesStackView].forEach { addSubview($0) }
        if comics.count > 2 { setupOtherComicsLabel() }
        setupThumbnailStackView()
        setupStackViews()
        setupConstraints()
    }
    
    private func setupOtherComicsLabel() {
        otherComicsLabel = UILabel()
        addSubview(otherComicsLabel!)
        otherComicsLabel?.textColor = .white
        otherComicsLabel?.textAlignment = .center
        otherComicsLabel?.font = UIFont.systemFont(ofSize: 17)
        otherComicsLabel?.accessibilityIdentifier = "otherComicsLabelIdentifier"
        let numberOfComics = comics.count - 2
        otherComicsLabel?.text = numberOfComics > 1 ? "and \(numberOfComics) other comics" : "and \(numberOfComics) other comic"
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
    
    private func setupThumbnailStackView() {
        thumbNailStackView.addArrangedSubview(firstImageView)
        thumbNailStackView.addArrangedSubview(secondImageView)
        titlesStackView.addArrangedSubview(firstTitleLabel)
        titlesStackView.addArrangedSubview(secondTitleLabel)
    }
    
    private func setupStackViews() {
        if let comics = comics, comics.count > 1 {
            var comicCount = 0
            
            [firstImageView, secondImageView].forEach {
                if let imageUrl = comics[comicCount].thumbnail.imageUrl() {
                    $0.loadImage(with: imageUrl)
                    comicCount += 1
                }
            }
            comicCount = 0
            [firstTitleLabel, secondTitleLabel].forEach {
                $0.text = comics[comicCount].title
            }
        }
    }
    
    private func setupConstraints() {
        thumbNailStackView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: ((UIScreen.main.bounds.width - 48) / 2) * 1.41)
        titlesStackView.anchor(top: thumbNailStackView.bottomAnchor, left: leftAnchor, bottom: otherComicsLabel != nil ? nil : bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: otherComicsLabel != nil ? 0 : 16, paddingRight: 16, width: 0, height: 0)
        otherComicsLabel?.anchor(top: titlesStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 35, paddingLeft: 16, paddingBottom: 47, paddingRight: 16, width: 0, height: 0)
    }
}
