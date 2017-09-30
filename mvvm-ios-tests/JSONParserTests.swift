//
//  JSONParserTests.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/30/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import XCTest
@testable import mvvm_ios

class JSONParserTests: XCTestCase{
  
  var parser: JSONParser!
  override func setUp() {
    super.setUp()
    parser = JSONParser()
  }
  
  override func tearDown() {
    super.tearDown()
    parser = nil
  }

  func testThatJSONParserShouldReturnReposListFromCorrectJSON() {
    // Given
    let data = TestDataUtils.getRawJSONData()
    
    // When
    let repos = parser.decode(from: data)
    
    // Then
    XCTAssertEqual(repos, TestDataUtils.getSimpleMockRepos())
  }
}
