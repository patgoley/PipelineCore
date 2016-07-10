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
        
        let expt = expectation(withDescription: "error")
        
        let fiveError = errorMap(throwingThunkify(5)) |> expectError(expt)
        
        fiveError()
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testSyncErrorMapSyncProducer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveSuccess = errorMap(safeThunkify(5)) |> expectSuccess(expt, 5)
        
        fiveSuccess()
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testErrorMapThrowingAsyncProducer() {
        
        let expt = expectation(withDescription: "error")
        
        let errorFunc = errorMap(throwingAsyncThunkify(5))
        
        let fiveError = errorFunc |> expectError(expt)
        
        fiveError() {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testErrorMapAsyncProducer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveSuccess = errorMap(safeAsyncThunkify(5)) |> expectSuccess(expt, 5)
        
        fiveSuccess() {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // MARK:- Transformers

    func testErrorMapThrowingSyncTransformer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveToString = thunkify(5) |> errorMap(throwingToString) |> expectError(expt)
        
        fiveToString()
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testrrorMapSyncTransformer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveToString = thunkify(5) |> errorMap(safeToString) |> expectSuccess(expt, "5")
        
        fiveToString()
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testErrorMapThrowingAsyncTransformer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveToString = thunkify(5) |> errorMap(asyncThrowingToString) |> expectError(expt)
        
        fiveToString() {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testErrorMapAsyncTransformer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveToString = thunkify(5) |> errorMap(asyncSafeToString) |> expectSuccess(expt, "5")
        
        fiveToString() {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // MARK:- Consumers
    
    func testErrorMapThrowingSyncConsumer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveError = thunkify(5) |> errorMap(throwingConsumer(expt))
        
        let result = fiveError()
        
        XCTAssert(result.dynamicType == Optional<ErrorProtocol>.self)
        
        XCTAssertNotNil(result)
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testErrorMapSyncConsumer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveSuccess = thunkify(5) |> errorMap(safeConsumer(expt, 5))
        
        let result = fiveSuccess()
        
        XCTAssert(result.dynamicType == Optional<ErrorProtocol>.self)
        
        XCTAssertNil(result)
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testErrorMapThrowingAsyncConsumer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveError = thunkify(5) |> errorMap(throwingAsyncConsumer(expt))
        
        fiveError() { result in
            
            XCTAssert(result.dynamicType == Optional<ErrorProtocol>.self)
            
            XCTAssertNotNil(result)
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testErrorMapAsyncConsumer() {
        
        let expt = expectation(withDescription: "error")
        
        let fiveError = thunkify(5) |> errorMap(safeAsyncConsumer(expt, 5))
        
        fiveError() { result in
            
            XCTAssert(result.dynamicType == Optional<ErrorProtocol>.self)
            
            XCTAssertNil(result)
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
}
