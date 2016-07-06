//
//  MockThrowingFunctions.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/4/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import Foundation
import PipelineCore
import XCTest

struct MockError: ErrorType { }

func expectSuccess<T: Equatable>(expectation: XCTestExpectation, _ expectedValue: T) -> Result<T> -> Void {
    
    return { value in
        
        switch value {
        case .Error(_): XCTFail()
        default: expectation.fulfill()
        }
    }
}

func expectError<T: Equatable>(expectation: XCTestExpectation) -> Result<T> -> Void {
    
    return { value in
        
        switch value {
        case .Success(_): XCTFail()
        default: expectation.fulfill()
        }
    }
}

func throwingConsumer<T: Equatable>(expectation: XCTestExpectation) -> T throws -> Void {
    
    return { value in
        
        expectation.fulfill()
        
        throw MockError()
    }
}

func safeConsumer<T: Equatable>(expectation: XCTestExpectation, _ expectedValue: T) -> T throws -> Void {
    
    return { value in
        
        XCTAssert(value == expectedValue)
        
        expectation.fulfill()
    }
}

func throwingAsyncConsumer<T: Equatable>(expectation: XCTestExpectation) -> (T, () -> Void) throws -> Void {
    
    return { value, compeltion in
        
        expectation.fulfill()
        
        throw MockError()
    }
}

func safeAsyncConsumer<T: Equatable>(expectation: XCTestExpectation, _ expectedValue: T) -> (T, () -> Void) throws -> Void {
    
    return { value, completion in
        
        XCTAssert(value == expectedValue)
        
        expectation.fulfill()
        
        completion()
    }
}

func throwingThunkify<T>(value: T) -> () throws -> T {
    
    return {
        
        throw MockError()
    }
}

func safeThunkify<T>(value: T) -> () throws -> T {
    
    return {
        
        return value
    }
}

func throwingAsyncThunkify<T>(value: T) -> ((T -> Void)) throws -> Void {
    
    return { completion in
        
        throw MockError()
    }
}

func safeAsyncThunkify<T>(value: T) -> ((T) -> Void) throws -> Void {
    
    return { completion in
        
         completion(value)
    }
}

func throwingToString<T: CustomStringConvertible>(value: T) throws -> String {
    
    throw MockError()
}


func safeToString<T: CustomStringConvertible>(value: T) throws -> String {
    
    return value.description
}

func asyncThrowingToString<T: CustomStringConvertible>(value: T, completion: (String) -> Void) throws {
    
    throw MockError()
}


func asyncSafeToString<T: CustomStringConvertible>(value: T, completion: (String) -> Void) throws {
    
    completion(value.description)
    
    return
}