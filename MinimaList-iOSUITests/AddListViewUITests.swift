//
//  AddListViewUITests.swift
//  MinimaLists-iOSUITests
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import XCTest

final class AddListViewUITests: XCTestCase {

    override func setUpWithError() throws {
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
        app.launch()
        
        // Given
        
        waitExists(app.images.element(matching: .label("add.list")), timeOut: 4)
        
        // When
        app.images.element(matching: .label("add.list")).firstMatch.tap()
        waitExists(app.textFields.matching(identifier: "List name").element, timeOut: 4)
        
        // Then
        XCTAssert(app.navigationBars.staticTexts.matching(label: "Lists").exists)
        XCTAssert(app.textFields.matching(identifier: "Foot note").element.exists)
        XCTAssert(app.images.element(matching: .label("x.circle")).exists)
    }
    
    func testShowsButtonWhenListNameTypedIn() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Given
        waitExists(app.images.element(matching: .label("add.list")), timeOut: 4)
        
        // When
        app.images.element(matching: .label("add.list")).firstMatch.tap()
        waitExists(app.textFields.matching(identifier: "List name").element, timeOut: 4)
        app.textFields.matching(identifier: "List name").element.typeText("New List")
        XCTAssert(app.buttons.matching(identifier: "Save").element.exists)
    }
    
    func testShowsNameAlreadyUsed() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Given
        waitExists(app.images.element(matching: .label("add.list")), timeOut: 4)
        
        // When
        app.images.element(matching: .label("add.list")).firstMatch.tap()
        waitExists(app.textFields.matching(identifier: "List name").element, timeOut: 4)
        app.textFields.matching(identifier: "List name").element.typeText("Groceries")
        XCTAssert(app.staticTexts.matching(identifier: "Name already used").element.exists)
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
