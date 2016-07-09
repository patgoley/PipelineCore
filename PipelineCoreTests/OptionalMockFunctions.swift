//
//  OptionalMockFunctions.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/8/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import Foundation
import XCTest

func expect(expt: XCTestExpectation) -> () -> Void {
    
    return {
        
        expt.fulfill()
    }
}

func failTest(int: Int) {
    
    XCTFail()
}

func optionalThunkify<T>(value: T) -> () -> T? {
    
    return {
        
        return value
    }
}

func nilThunk() -> Int? {
    
    return nil
}

func stringToInt(string: String) -> Int? {
    
    return Int(string)
}

func transformToNil<T>(value: T) -> T? {
    
    return nil
}

// Async

func asyncFailTest(value: Int, completion: () -> Void) -> Void {
    
    XCTFail()
}

func asyncOptionalThunkify<T>(value: T) -> ((T?) -> Void) -> Void {
    
    return { completion in
        
         completion(value)
    }
}

func asyncNilThunk(completion: (Int?) -> Void) {
    
    completion(nil)
}

func asyncStringToInt(string: String) -> Int? {
    
    return Int(string)
}

func asyncTransformToNil<T>(value: T) -> T? {
    
    return nil
}



