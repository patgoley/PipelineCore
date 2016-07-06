//
//  FunctionOperators.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 arbiter. All rights reserved.
//

import Foundation

/*
 The following overload allows the chaining of any two
 synchronous functions, as long as they meet certain type
 constraints.
 
 A synchronous function has one of the following signatures:
 
 producer: () -> T
 
 transformer: T -> U
 
 consumer: T -> Void
 
 Even though this overload appears to be only for chaining two
 transformers, it also applies where T or U are () meaning that 
 neither of the functions are required to take input or produce 
 a return value.
*/

public func |> <T, U, V>(lhs: T -> U, rhs: U -> V) -> T -> V  {
    
    return { value in
        
        let transformed = lhs(value)
        
        return rhs(transformed)
    }
}