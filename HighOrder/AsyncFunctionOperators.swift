//
//  AsyncFunctionOperators.swift
//  Pipeline
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 arbiter. All rights reserved.
//

import Foundation

/*
 The following overloads allow the chaining of any synchronous or asynchronous functions. 
 An asynchronous function has one of the following signatures:
 
 producer: ((T) -> Void) -> Void
 
 transformer: (T, (U) -> Void) -> Void
 
 consumer: (T, () -> Void) -> Void
 
 Note that chaining a consumer is the same as chaining a transformer where U == Void, so
 these use cases are covered by the operators for chaining transformers.
*/

// MARK: Producers

// sync producer, async transformer

public func |> <T, U>(lhs: () -> T, rhs: (T, (U) -> Void) -> Void) -> ((U) -> Void) -> Void  {
    
    return { (completion: (U) -> Void) in
        
        let value = lhs()
        
        rhs(value, completion)
    }
}

// async producer, sync transformer

public func |> <T, U>(lhs: ((T) -> Void) -> Void, rhs: T -> U) -> ((U) -> Void) -> Void  {
    
    return { (completion: (U) -> Void) in
        
        lhs() { (value: T) in
            
            let newValue = rhs(value)
            
            completion(newValue)
        }
    }
}

// async producer, async transformer

public func |> <T, U>(lhs: ((T) -> Void) -> Void, rhs: (T, (U) -> Void) -> Void) -> ((U) -> Void) -> Void  {
    
    return { (completion: (U) -> Void) in
        
        lhs() { (value: T) in
            
            rhs(value, completion)
        }
    }
}


// MARK: Transformers

// async transformer, sync transformer

public func |> <T, U, V>(lhs: (T, (U) -> Void) -> Void, rhs: U -> V) -> (T, (V) -> Void) -> Void  {
    
    return { (value: T, completion: (V) -> Void) in
        
        lhs(value) { (result: U) in
            
            let finalValue = rhs(result)
            
            completion(finalValue)
        }
    }
}

// async transformer, async transformer

public func |> <T, U, V>(lhs: (T, (U) -> Void) -> Void, rhs: (U, V -> Void) -> Void) -> (T, (V) -> Void) -> Void  {
    
    return { (value: T, completion: (V) -> Void) in
        
        lhs(value) { (result: U) in
            
            rhs(result, completion)
        }
    }
}

// sync transformer, async transformer

public func |> <T, U, V>(lhs: (T) -> U, rhs: (U, V -> Void) -> Void) -> (T, (V) -> Void) -> Void  {
    
    return { (value: T, completion: (V) -> Void) in
        
        let newValue = lhs(value)
        
        rhs(newValue, completion)
    }
}


// MARK: Consumers

// async consumer, sync producer

public func |> <U, V>(lhs: (U, () -> Void) -> Void, rhs: () -> V) -> (U, (V) -> Void) -> Void  {
    
    return { (value: U, completion: (V) -> Void) in
        
        lhs(value) {
            
            let newValue = rhs()
            
            completion(newValue)
        }
    }
}

// async consumer, async producer

public func |> <T, U>(lhs: (T, () -> Void) -> Void, rhs: (U -> Void) -> Void) -> (T, (U) -> Void) -> Void  {
    
    return { (value: T, completion: (U) -> Void) in
        
        lhs(value) {
            
            rhs(completion)
        }
    }
}

// sync consumer, async producer

public func |> <T, U>(lhs: (T) -> Void, rhs: (U -> Void) -> Void) -> (T, (U) -> Void) -> Void  {
    
    return { (value: T, completion: (U) -> Void) in
        
        lhs(value)
        
        rhs(completion)
    }
}
