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
    
    func testSyncErrorMapThrowingProducer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveError = errorMap(throwingThunkify(5)) |> expectError(expt)
        
        fiveError()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testSyncErrorMapProducer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveSuccess = errorMap(safeThunkify(5)) |> expectSuccess(expt, 5)
        
        fiveSuccess()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    func testSyncErrorMapThrowingTransformer() {
        
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
