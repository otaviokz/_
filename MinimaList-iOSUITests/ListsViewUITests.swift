//
//  MinimaList_iOSUITests.swift
//  MinimaList-iOSUITests
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import XCTest
import SwiftUITestUtils

final class MinimaList_iOSUITests: XCTestCase {
    
    override func setUpWithError() throws {
        let app = XCUIApplication()
        app.launch()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBasics() throws {
        let app = XCUIApplication()
        app.launchWithTestFlags()
        
        // Given
        waitExists(app.images.element(matching: .label("add.list")), timeOut: 4)
        
        // When
        app.images.element(matching: .label("add.list")).firstMatch.tap()
        waitExists(app.textFields.matching(identifier: "List name").element, timeOut: 4)
        
        // Then
        XCTAssert(app.textViews.matching(identifier: "Foot note").element.exists)
        XCTAssert(app.images.element(matching: .label("x.circle")).exists)
    }
    
    func testShowsFetchedListsAfterIndicator() throws {
        let app = XCUIApplication()
        app.launchWithTestFlags()
        waitDontExists(app.progressIndicators.element, timeOut: 3)
        XCTAssert(app.staticTexts.matching(label: "Groceries").exists)
        XCTAssert(app.staticTexts.matching(label: "High Street Shopping").exists)
        XCTAssert(app.staticTexts.matching(label: "SwiftUI & Combine: Main Chapters").exists)
        XCTAssert(app.staticTexts.matching(label: "Tech Debts MinimaLists").exists)
        XCTAssert(app.staticTexts.matching(label: "Movies").exists)
    }
}

extension XCUIApplication {
    func launchWithTestFlags() {
        launchArguments = [ "testMode" ]
        launch()
    }
}

