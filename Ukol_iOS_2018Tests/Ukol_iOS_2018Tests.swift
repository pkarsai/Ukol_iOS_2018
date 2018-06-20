//
//  Ukol_iOS_2018Tests.swift
//  Ukol_iOS_2018Tests
//
//  Created by Péter Karsai on 2018.06.19..
//  Copyright © 2018. My Web Kft. All rights reserved.
//

import XCTest
@testable import Ukol_iOS_2018

class Ukol_iOS_2018Tests: XCTestCase {
    
    var note: Note!
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        note = Note(id: 1, title: "Unit test note")
        XCTAssertEqual(note.id!, 1, "Test failed for note initializer (.id)")
        XCTAssertEqual(note.title!, "Unit test note", "Test failed for note initializer (.title)")
    }
    
}
