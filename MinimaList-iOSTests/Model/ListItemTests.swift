//
//  ListItemTests.swift
//  MinimaList-iOSTests
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import XCTest
@testable import MinimaLists_iOS

final class ListItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodable() throws {
        // Given:
        let groceries = try JsonLoader.groceryItems().sortedByName
        
        // Then:
        XCTAssertEqual(groceries.count, 5)
        let first = groceries[0]

        XCTAssertEqual(first.name, "Carrots")
        XCTAssertNil(first.note)
        XCTAssertEqual(first.list, "Groceries")
        
        let last = groceries[4]
        XCTAssertEqual(last.name, "Tomatoes")
        XCTAssertEqual(last.note, "Preferably the Spanish ones")
        XCTAssertEqual(last.list, "Groceries")
        
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
