//
//  ErrorHandlingTests.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/4/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import XCTest
import PipelineCore

class ErrorHandlingTests: XCTestCase {
    
    // MARK:- Producers
    
    func testErrorMapSyncThrowingProducer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveError = errorMap(throwingThunkify(5)) |> expectError(expt)
        
        fiveError()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testSyncErrorMapSyncProducer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveSuccess = errorMap(safeThunkify(5)) |> expectSuccess(expt, 5)
        
        fiveSuccess()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testErrorMapThrowingAsyncProducer() {
        
        let expt = expectationWithDescription("error")
        
        let errorFunc = errorMap(throwingAsyncThunkify(5))
        
        let fiveError = errorFunc |> expectError(expt)
        
        fiveError() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testErrorMapAsyncProducer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveSuccess = errorMap(safeAsyncThunkify(5)) |> expectSuccess(expt, 5)
        
        fiveSuccess() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // MARK:- Transformers

    func testErrorMapThrowingSyncTransformer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveToString = thunkify(5) |> errorMap(throwingToString) |> expectError(expt)
        
        fiveToString()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testrrorMapSyncTransformer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveToString = thunkify(5) |> errorMap(safeToString) |> expectSuccess(expt, "5")
        
        fiveToString()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testErrorMapThrowingAsyncTransformer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveToString = thunkify(5) |> errorMap(asyncThrowingToString) |> expectError(expt)
        
        fiveToString() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testErrorMapAsyncTransformer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveToString = thunkify(5) |> errorMap(asyncSafeToString) |> expectSuccess(expt, "5")
        
        fiveToString() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // MARK:- Consumers
    
    func testErrorMapThrowingSyncConsumer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveError = thunkify(5) |> errorMap(throwingConsumer(expt))
        
        let result = fiveError()
        
        XCTAssert(result.dynamicType == Optional<ErrorType>.self)
        
        XCTAssertNotNil(result)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testErrorMapSyncConsumer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveSuccess = thunkify(5) |> errorMap(safeConsumer(expt, 5))
        
        let result = fiveSuccess()
        
        XCTAssert(result.dynamicType == Optional<ErrorType>.self)
        
        XCTAssertNil(result)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testErrorMapThrowingAsyncConsumer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveError = thunkify(5) |> errorMap(throwingAsyncConsumer(expt))
        
        fiveError() { result in
            
            XCTAssert(result.dynamicType == Optional<ErrorType>.self)
            
            XCTAssertNotNil(result)
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testErrorMapAsyncConsumer() {
        
        let expt = expectationWithDescription("error")
        
        let fiveError = thunkify(5) |> errorMap(safeAsyncConsumer(expt, 5))
        
        fiveError() { result in
            
            XCTAssert(result.dynamicType == Optional<ErrorType>.self)
            
            XCTAssertNil(result)
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
