//
//  OptionalMockFunctions.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/8/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import Foundation
import XCTest

func failTest(int: Int) {
    
    XCTFail()
}

func optionalThunkify<T>(value: T) -> () -> T? {
    
    return {
        
        return value
    }
}

func nilThunk<T>() -> T? {
    
    return nil
}

func stringToInt(string: String) -> Int? {
    
    return Int(string)
}

func transformToNil<T>(value: T) -> T? {
    
    return nil
}

// Async

func asyncFailTest() -> (Int) -> Void {
    
    return { value in XCTFail() }
}

func asyncOptionalThunkify<T>(value: T) -> ((T) -> Void) -> Void {
    
    return { completion
        
        return value
    }
}

func nilThunk<T>() -> ((T?) -> Void) -> Void {
    
    return { completion in
        
        completion(nil)
    }
}

func stringToInt(string: String) -> Int? {
    
    return Int(string)
}

func transformToNil<T>(value: T) -> T? {
    
    return nil
}



