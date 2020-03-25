//
//  SwiftyMenuTests.swift
//  SwiftyMenu_Tests
//
//  Created by Karim Ebrahem on 3/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyMenu

class SwiftyMenuTests: XCTestCase {
    
    var sut: SwiftyMenu?
    var swiftyMenuDelegateSpy: SwiftyMenuDelegateSpy?

    override func setUp() {
        sut = SwiftyMenu()
        sut?.heightConstraint = NSLayoutConstraint(item: sut!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
        swiftyMenuDelegateSpy = SwiftyMenuDelegateSpy()
        sut?.delegate = swiftyMenuDelegateSpy
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        swiftyMenuDelegateSpy = nil
        super.tearDown()
    }

    func testWillExpandDelegateSuccessCalled() {
        // When
        sut?.toggle()
        
        // Then
        XCTAssertTrue(swiftyMenuDelegateSpy?.willExpandCalled ?? false)
    }
    
    func testDidExpandDelegateSuccessCalled() {
        // Given
        let didExpandExpectation = expectation(description: "SwiftyMenu doing some animation and will call this callback when finish")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            XCTAssertTrue(self.swiftyMenuDelegateSpy!.didExpandCalled)
            didExpandExpectation.fulfill()
        }
        // When
        sut?.toggle()
        
        // Wait
        waitForExpectations(timeout: 3) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
          }
        }
    }
    
    func testWillCollapseDelegateSuccessCalled() {
        // When
        sut?.toggle()
        sut?.toggle()
        
        // Then
        XCTAssertTrue(swiftyMenuDelegateSpy!.willCollapseCalled)
    }
    
    func testDidCollapseDelegateSuccessCalled() {
        // Given
        let didCollapseExpectation = expectation(description: "SwiftyMenu doing some animation and will call this callback when finish")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            XCTAssertTrue(self.swiftyMenuDelegateSpy!.didCollapseCalled)
            didCollapseExpectation.fulfill()
        }
        
        // When
        sut?.toggle()
        sut?.toggle()
        
        // Wait
        waitForExpectations(timeout: 3) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
          }
        }
    }
    
    func testWillExpandCallbackSuccessCalled() {
        // Given
        var willExpandCallbackCalled = false
        sut?.willExpand = {
            willExpandCallbackCalled = true
        }
        
        // When
        sut?.toggle()
        
        // Then
        XCTAssertTrue(willExpandCallbackCalled)
    }
    
    func testDidExpandCallbackSuccessCalled() {
        // Given
        let didExpandExpectation = expectation(description: "SwiftyMenu doing some animation and will call this callback when finish")
        var didExpandCallbackCalled = false
        sut?.didExpand = {
            didExpandCallbackCalled = true
            
            // Then
            XCTAssertTrue(didExpandCallbackCalled)
            didExpandExpectation.fulfill()
        }
        
        // When
        sut?.toggle()
        
        // Wait
        waitForExpectations(timeout: 3) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
          }
        }
    }
    
    func testWillCollapseCallbackSuccessCalled() {
        // Given
        var willCollapseCallbackCalled = false
        sut?.willCollapse = {
            willCollapseCallbackCalled = true
        }
        
        // When
        sut?.toggle()
        sut?.toggle()
        
        // Then
        XCTAssertTrue(willCollapseCallbackCalled)
    }
    
    func testDidCollapseCallbackSuccessCalled() {
        // Given
        let didCollapsExpectation = expectation(description: "SwiftyMenu doing some animation and will call this callback when finish")
        var didCollapseCallbackCalled = false
        sut?.didCollapse = {
            didCollapseCallbackCalled = true
            
            // Then
            XCTAssertTrue(didCollapseCallbackCalled)
            didCollapsExpectation.fulfill()
        }
        
        // When
        sut?.toggle()
        sut?.toggle()
        
        // Wait
        waitForExpectations(timeout: 3) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
          }
        }
    }

}
