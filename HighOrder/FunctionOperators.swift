//
//  FunctionOperators.swift
//  Pipeline
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 arbiter. All rights reserved.
//

import Foundation

public func |> <T, U, V>(lhs: T -> U, rhs: U -> V) -> T -> V  {
    
    return { value in
        
        let transformed = lhs(value)
        
        return rhs(transformed)
    }
}