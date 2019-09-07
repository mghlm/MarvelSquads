//
//  MarvelSquadsUITests.swift
//  MarvelSquadsUITests
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest

class MarvelSquadsUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testGoToCharacterDetailsFlow() {
        
        // Assert Home Screen
        HomeUIScreen.assertScreenExist(in: app)
        
        // Navigate to details
        HomeUIScreen.tableView.component(in: app).cells.element(boundBy: 1).tap()
        
        // Assert details screen
        CharacterDetailsUIScreen.assertScreenExist(in: app)
    }

}
