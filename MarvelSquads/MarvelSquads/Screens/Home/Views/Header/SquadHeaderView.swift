//
//  SquadHeaderView.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 05/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class SquadHeaderView: UIView {
    
    // MARK: - Private properties
    
    var squadMembers: [SquadMember] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didTapSquadMember: ((SquadMember) -> Void)?
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lbl.text = "My Squad"
        
        return lbl
    }()
    
    private var collectionView: UICollectionView!
    
    // MARK: - Init
    
    init(frame: CGRect, squadMembers: [SquadMember]) {
        self.squadMembers = squadMembers
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = Color.background.value
        addSubview(titleLabel)
        setupCollectionView()
        setupConstraints()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 64, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Color.background.value
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
        collectionView.register(SquadHeaderCollectionViewCell.self, forCellWithReuseIdentifier: SquadHeaderCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
    }
}

extension SquadHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return squadMembers.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let squadMember = squadMembers[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquadHeaderCollectionViewCell.id, for: indexPath) as! SquadHeaderCollectionViewCell
        cell.squadMember = squadMember
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let squadMember = squadMembers[indexPath.row]
        didTapSquadMember?(squadMember)
    }
}

