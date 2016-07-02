//
//  FunctionOperators.swift
//  Pipeline
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 arbiter. All rights reserved.
//

import Foundation


// MARK: Producers

// producer, consumer

public func |> <T>(lhs: () -> T, rhs: T -> ()) -> () -> Void  {
    
    return {
        
        let value = lhs()
        
        rhs(value)
    }
}

// producer, transformer

public func |> <T, U>(lhs: () -> T, rhs: T -> U) -> () -> U  {
    
    return {
        
        let value = lhs()
        
        return rhs(value)
    }
}


// MARK: Transformers

// transformer, consumer

public func |> <T, U>(lhs: T -> U, rhs: U -> Void) -> T -> Void  {
    
    return { value in
        
        let transformed = lhs(value)
        
        rhs(transformed)
    }
}

// transformer, transformer

public func |> <T, U, V>(lhs: T -> U, rhs: U -> V) -> T -> V  {
    
    return { value in
        
        let transformed = lhs(value)
        
        return rhs(transformed)
    }
}


// MARK: Consumers

// consumer, producer

public func |> <T, U>(lhs: T -> (), rhs: () -> U) -> T -> U  {
    
    return { value in
        
        lhs(value)
        
        return rhs()
    }
}