//
//  ErrorHandlingTests.swift
//  HighOrder
//
//  Created by Patrick Goley on 7/4/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import XCTest
import HighOrder

class ErrorHandlingTests: XCTestCase {

    func testSyncErrorMapThrow() {
        
        let expt = expectationWithDescription("error")
        
        let fiveToString = thunkify(5) |> errorMap(throwingToString) |> expectError(expt)
        
        fiveToString()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testSyncErrorMapNoThrow() {
        
        let expt = expectationWithDescription("error")
        
        let fiveToString = thunkify(5) |> errorMap(safeToString) |> expectSuccess(expt, "5")
        
        fiveToString()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testAsyncErrorMapThrow() {
        
        let expt = expectationWithDescription("error")
        
        let fiveToString = thunkify(5) |> errorMap(asyncThrowingToString) |> expectError(expt)
        
        fiveToString() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testAsyncErrorMapNoThrow() {
        
        let expt = expectationWithDescription("error")
        
        let fiveToString = thunkify(5) |> errorMap(asyncSafeToString) |> expectSuccess(expt, "5")
        
        fiveToString() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
