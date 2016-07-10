//
//  MockFunctions.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import Foundation
import XCTest

func expect<T: Equatable>(_ expectation: XCTestExpectation, _ expectedValue: T) -> (T) -> Void {
    
    return { value in
        
        XCTAssert(value == expectedValue)
        
        expectation.fulfill()
    }
}

func thunkify<T>(_ value: T) -> () -> T {

    return {
        
        return value
    }
}

func addFive(_ value: Int) -> Int {
    
    return value + 5
}

func toString<T: CustomStringConvertible>(_ value: T) -> String {
    
    return value.description
}
