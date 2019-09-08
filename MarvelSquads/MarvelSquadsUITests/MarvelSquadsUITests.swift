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
        let cell = HomeUIScreen.tableView.component(in: app).cells.element(boundBy: 1)
        waitForElementToAppear(element: cell, timeout: 20)
        cell.tap()
        
        // Assert details screen
        CharacterDetailsUIScreen.assertScreenExist(in: app)

    }
    
    private func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 5,  file: String = #file, line: Int = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate,
                                evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: line, expected: true)
            }
        }
    }

}
