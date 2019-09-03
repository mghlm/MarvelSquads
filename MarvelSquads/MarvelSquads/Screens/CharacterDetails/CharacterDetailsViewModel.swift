//
//  CharacterDetailsViewModel.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol CharacterDetailsViewModelType {
    var character: Character { get }
}

final class CharacterDetailsViewModel: CharacterDetailsViewModelType {
    
    // MARK: - Dependencies
    
    var character: Character
    
    // MARK: - Init
    
    init(character: Character) {
        self.character = character
    }
    
}
