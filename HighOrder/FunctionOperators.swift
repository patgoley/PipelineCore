//
//  FunctionOperators.swift
//  Pipeline
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 arbiter. All rights reserved.
//

import Foundation

/*
 The following overload allows the chaining of any two
 synchronous functions, as long as they meet certain type
 constraints.
 
 This overload is also usable where any of
 T, U, or V are (), meaning that neither of the functions
 are required to take input or produce a return value.
 
 This allows any one or zero arity function to be chained
 to any other one or zero arity function. If `lhs`
 produces a return value and the `rhs` accepts an
 argument, the result of `lhs` is passed to `rhs`.
*/

public func |> <T, U, V>(lhs: T -> U, rhs: U -> V) -> T -> V  {
    
    return { value in
        
        let transformed = lhs(value)
        
        return rhs(transformed)
    }
}