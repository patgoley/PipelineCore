//
//  MockFunctions.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import Foundation
import XCTest

func expect<T: Equatable>(expectation: XCTestExpectation, _ expectedValue: T) -> T -> Void {
    
    return { value in
        
        XCTAssert(value == expectedValue)
        
        expectation.fulfill()
    }
}

func thunkify<T>(value: T) -> () -> T {

    return {
        
        return value
    }
}

func addFive(value: Int) -> Int {
    
    return value + 5
}

func toString<T: CustomStringConvertible>(value: T) -> String {
    
    return value.description
}