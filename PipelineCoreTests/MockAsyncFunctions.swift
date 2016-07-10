//
//  MockAsyncFunctions.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import Foundation
import XCTest

func asyncExpect<T: Equatable>(_ expectation: XCTestExpectation, _ expectedValue: T) -> (T, () -> Void) -> Void {
    
    return { value, completion in
        
        XCTAssert(value == expectedValue)
        
        expectation.fulfill()
        
        completion()
    }
}

func asyncThunkify<T>(_ value: T) -> ((T) -> Void) -> Void {
    
    return { completion in
        
        return completion(value)
    }
}

func asyncAddFive(_ value: Int, _ completion: (Int) -> Void) {
    
    completion(value + 5)
}

func asyncToString<T: CustomStringConvertible>(_ value: T, completion: (String) -> Void) {
    
     completion(value.description)
}
