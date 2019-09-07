//
//  HomeUIScreen.swift
//  MarvelSquadsUITests
//
//  Created by Magnus Holm on 07/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest

enum HomeUIScreen {
    case headerView, tableView
    
    func component(in app: XCUIApplication) -> XCUIElement {
        switch self {
        case .headerView:
            return app.otherElements["homeScreenHeaderView"]
        case .tableView:
            return app.tables["homeScreenTableViewIdentifier"]
        }
    }
    
    static func assertScreenExist(in app: XCUIApplication) {
        XCTAssert(HomeUIScreen.headerView.component(in: app).exists)
        XCTAssert(HomeUIScreen.tableView.component(in: app).waitForExistence(timeout: 5))
    }
    
    static func assertScreenDoesNotExist(in app: XCUIApplication) {
        XCTAssertFalse(HomeUIScreen.headerView.component(in: app).exists)
        XCTAssertFalse(HomeUIScreen.tableView.component(in: app).exists)
    }
}
