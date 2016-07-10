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

struct MockError: ErrorProtocol { }

func expectSuccess<T: Equatable>(_ expectation: XCTestExpectation, _ expectedValue: T) -> (Result<T>) -> Void {
    
    return { value in
        
        switch value {
        case .error(_): XCTFail()
        default: expectation.fulfill()
        }
    }
}

func expectError<T: Equatable>(_ expectation: XCTestExpectation) -> (Result<T>) -> Void {
    
    return { value in
        
        switch value {
        case .success(_): XCTFail()
        default: expectation.fulfill()
        }
    }
}

func throwingConsumer<T: Equatable>(_ expectation: XCTestExpectation) -> (T) throws -> Void {
    
    return { value in
        
        expectation.fulfill()
        
        throw MockError()
    }
}

func safeConsumer<T: Equatable>(_ expectation: XCTestExpectation, _ expectedValue: T) -> (T) throws -> Void {
    
    return { value in
        
        XCTAssert(value == expectedValue)
        
        expectation.fulfill()
    }
}

func throwingAsyncConsumer<T: Equatable>(_ expectation: XCTestExpectation) -> (T, () -> Void) throws -> Void {
    
    return { value, compeltion in
        
        expectation.fulfill()
        
        throw MockError()
    }
}

func safeAsyncConsumer<T: Equatable>(_ expectation: XCTestExpectation, _ expectedValue: T) -> (T, () -> Void) throws -> Void {
    
    return { value, completion in
        
        XCTAssert(value == expectedValue)
        
        expectation.fulfill()
        
        completion()
    }
}

func throwingThunkify<T>(_ value: T) -> () throws -> T {
    
    return {
        
        throw MockError()
    }
}

func safeThunkify<T>(_ value: T) -> () throws -> T {
    
    return {
        
        return value
    }
}

func throwingAsyncThunkify<T>(_ value: T) -> (((T) -> Void)) throws -> Void {
    
    return { completion in
        
        throw MockError()
    }
}

func safeAsyncThunkify<T>(_ value: T) -> ((T) -> Void) throws -> Void {
    
    return { completion in
        
         completion(value)
    }
}

func throwingToString<T: CustomStringConvertible>(_ value: T) throws -> String {
    
    throw MockError()
}


func safeToString<T: CustomStringConvertible>(_ value: T) throws -> String {
    
    return value.description
}

func asyncThrowingToString<T: CustomStringConvertible>(_ value: T, completion: (String) -> Void) throws {
    
    throw MockError()
}


func asyncSafeToString<T: CustomStringConvertible>(_ value: T, completion: (String) -> Void) throws {
    
    completion(value.description)
    
    return
}
