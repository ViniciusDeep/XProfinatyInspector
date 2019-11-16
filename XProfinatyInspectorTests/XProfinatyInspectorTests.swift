//
//  XProfinatyInspectorTests.swift
//  XProfinatyInspectorTests
//
//  Created by Vinicius Mangueira on 15/11/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import XCTest
@testable import XProfinatyInspector

class XProfinatyInspectorTests: XCTestCase {


    func testProfinatyRepresentation() {
        XCTAssertNotNil(XProfinatyR.profanityFileURL())
        XCTAssertNotNil(XProfinatyWords.profaneWords)
    }
    
    
    func testProfinatyArguments() {
        XCTAssertEqual(true, "bitch".containsProfanity())
        XCTAssertEqual(true, "fuck of".containsProfanity())
        XCTAssertEqual(true, "motherfucker".containsProfanity())
        XCTAssertEqual(true, "cocksuck".containsProfanity())
        XCTAssertEqual(true, "bestial".containsProfanity())
        XCTAssertEqual(true, "duche".containsProfanity())
        XCTAssertEqual(true, "ejakulate".containsProfanity())
        XCTAssertEqual(true, "ejaculate".containsProfanity())
        XCTAssertEqual(true, "fanyy".containsProfanity())
        XCTAssertEqual(true, "dick".containsProfanity())
        XCTAssertEqual(true, "fingerfucked".containsProfanity())
        XCTAssertEqual(true, "fucka".containsProfanity())
        XCTAssertEqual(true, "son-of-a-bitch".containsProfanity())
        XCTAssertEqual(true, "xxx".containsProfanity())
        XCTAssertEqual(true, "willy".containsProfanity())
        XCTAssertEqual(true, "wang".containsProfanity())
        XCTAssertEqual(true, "twathead".containsProfanity())
        XCTAssertEqual(true, "titwank".containsProfanity())
    }

}
