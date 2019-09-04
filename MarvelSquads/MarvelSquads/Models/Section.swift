//
//  Section.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 04/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol Section {
    var sectionType: SectionType { get }
    var cellCount: Int { get }
}

struct CharacterDetailsSection: Section {
    var sectionType: SectionType {
        return .characterDetails
    }
    
    var cellCount: Int {
        return 1
    }
    
    var character: Character
}

struct ComicDetailsSection: Section {
    var sectionType: SectionType {
        return .comicDetails
    }
    
    var cellCount: Int {
        return 1
    }
    
    var comics: [Comic]
}

enum SectionType {
    case characterDetails, comicDetails
}
