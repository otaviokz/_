//
//  LeanLiistTests.swift
//  MinimaLists-iOSTests
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import XCTest
@testable import MinimaLists_iOS

final class LeanLiistTests: XCTestCase {

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
        XCTAssertEqual(lists[1].name, "SwiftUI Main Topics")
        XCTAssertEqual(lists[2].name, "ToDo")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
