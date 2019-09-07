//
//  CharacterDetailsUIScreen.swift
//  MarvelSquadsUITests
//
//  Created by Magnus Holm on 07/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest

enum CharacterDetailsUIScreen {
    case charactersTableView
    case characterDetailsCell, characterImageView, characterNameLabel, addToSquadButton, characterDescription
    case comicsCell, comicsStackView, comicsTitlesStackView, otherComicsLabel
    
    func component(in app: XCUIApplication) -> XCUIElement {
        switch self {
        case .charactersTableView:
            return app.tables["charactersTableViewIdentifier"]
        case .characterDetailsCell:
            return app.cells["characterDetailsCellIdentifier"]
        case .characterImageView:
            return app.otherElements["characterImageViewIdentifier"]
        case .characterNameLabel:
            return app.staticTexts["characterNameLabelIdentifier"]
        case .addToSquadButton:
            return app.buttons["addToSquadButtonIdentifier"]
        case .characterDescription:
            return app.staticTexts["characterDescriptionIdentifier"]
        case .comicsCell:
            return app.cells["comicsCellIdentifier"]
        case .comicsStackView:
            return app.otherElements["comicsStackViewIdentifier"]
        case .comicsTitlesStackView:
            return app.otherElements["comicsTitlesStackViewIdentifier"]
        case .otherComicsLabel:
            return app.staticTexts["otherComicsLabelIdentifier"]
        }
    }
    
    static func assertScreenExist(in app: XCUIApplication) {
        XCTAssert(CharacterDetailsUIScreen.charactersTableView.component(in: app).exists)
        XCTAssert(CharacterDetailsUIScreen.characterDetailsCell.component(in: app).exists)
        XCTAssert(CharacterDetailsUIScreen.characterImageView.component(in: app).exists)
        XCTAssert(CharacterDetailsUIScreen.characterNameLabel.component(in: app).exists)
        XCTAssert(CharacterDetailsUIScreen.addToSquadButton.component(in: app).exists)
        XCTAssert(CharacterDetailsUIScreen.characterDescription.component(in: app).exists)
        XCTAssert(CharacterDetailsUIScreen.comicsCell.component(in: app).exists)
        XCTAssert(CharacterDetailsUIScreen.comicsStackView.component(in: app).exists)
        XCTAssert(CharacterDetailsUIScreen.comicsTitlesStackView.component(in: app).exists)
        XCTAssert(CharacterDetailsUIScreen.otherComicsLabel.component(in: app).exists)
    }
    
    static func assertScreenDoesNotExist(in app: XCUIApplication) {
        XCTAssertFalse(CharacterDetailsUIScreen.charactersTableView.component(in: app).exists)
        XCTAssertFalse(CharacterDetailsUIScreen.characterDetailsCell.component(in: app).exists)
        XCTAssertFalse(CharacterDetailsUIScreen.characterImageView.component(in: app).exists)
        XCTAssertFalse(CharacterDetailsUIScreen.characterNameLabel.component(in: app).exists)
        XCTAssertFalse(CharacterDetailsUIScreen.addToSquadButton.component(in: app).exists)
        XCTAssertFalse(CharacterDetailsUIScreen.characterDescription.component(in: app).exists)
        XCTAssertFalse(CharacterDetailsUIScreen.comicsCell.component(in: app).exists)
        XCTAssertFalse(CharacterDetailsUIScreen.comicsStackView.component(in: app).exists)
        XCTAssertFalse(CharacterDetailsUIScreen.comicsTitlesStackView.component(in: app).exists)
        XCTAssertFalse(CharacterDetailsUIScreen.otherComicsLabel.component(in: app).exists)
    }
}
