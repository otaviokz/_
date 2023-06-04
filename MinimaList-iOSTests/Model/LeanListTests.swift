//
//  LeanListTests.swift
//  MinimaLists-iOSTests
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import XCTest
@testable import MinimaLists_iOS

final class LeanListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodable() throws {
        // Given
        let lists = try JsonLoader.leanLists().sortedByName
        
        // Then:
        XCTAssertEqual(lists.count, 3)
        XCTAssertEqual(lists[0].name, "Groceries")
        XCTAssertEqual(lists[0].footNote, "Try Farmers Market first")
        XCTAssertEqual(lists[1].name, "SwiftUI Main Topics")
        XCTAssertEqual(lists[1].footNote, "Tech Interview is next week")
        XCTAssertEqual(lists[2].name, "ToDo")
        XCTAssertNil(lists[2].footNote)
    }
}
