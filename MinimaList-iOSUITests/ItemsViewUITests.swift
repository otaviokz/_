//
//  ItemsViewUITests.swift
//  MinimaLists-iOSUITests
//
//  Created by Otávio Zabaleta on 05/06/2023.
//

import XCTest
import SwiftUITestUtils

final class ItemsViewUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func navigatesToGroceriesListItems(app: XCUIApplication) {
        waitExists(app.staticTexts.matching(label: "Groceries"), timeOut: 5)
        app.staticTexts.matching(label: "Groceries").tap()
        waitExists(app.navigationBars.staticTexts.matching(label: "Groceries"), timeOut: 2)
    }
    
    func testDisplayItems() throws {
        let app = XCUIApplication()
        app.launch()
        navigatesToGroceriesListItems(app: app)
        
        XCTAssert(app.staticTexts.matching(label: "12 Eggs").exists)
        XCTAssert(app.staticTexts.matching(label: "4 AA Batteries").exists)
        XCTAssert(app.staticTexts.matching(label: "Anchovies").exists)
        XCTAssert(app.images.matching(identifier: "Anchovies.info.img").element.exists)
        XCTAssert(app.staticTexts.matching(label: "Dove Soap").exists)
        XCTAssert(app.staticTexts.matching(label: "Carrots").exists)
        XCTAssert(app.images.matching(identifier: "Carrots.info.img").element.exists)
        XCTAssert(app.staticTexts.matching(label: "Shampoo").exists)
        XCTAssert(app.images.matching(identifier: "Shampoo.info.img").element.exists)
    }
    
    func testDisplaysInfo() throws {
        let app = XCUIApplication()
        app.launch()
        navigatesToGroceriesListItems(app: app)
        
        app.images.matching(identifier: "Anchovies.info.img").element.tap()
        waitExists(app.sheets.element, timeOut: 3)
        XCTAssert(app.staticTexts.matching(label: "The fresh ones, those canned are way too salty.").exists)
        
        app.swipeVertical(from: 0.6, to: 1)
        waitDontExists(app.sheets.element, timeOut: 3)
        app.images.matching(identifier: "Shampoo.info.img").element.tap()
        waitExists(app.sheets.element, timeOut: 3)
        XCTAssert(app.staticTexts.matching(label: "Clean & Clear").exists)
    }
}
