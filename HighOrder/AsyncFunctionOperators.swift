//
//  AsyncFunctionOperators.swift
//  Pipeline
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 arbiter. All rights reserved.
//

import Foundation


// MARK: Producers

// producer, async consumer

public func |> <T>(lhs: () -> T, rhs: (T, () -> Void) -> Void) -> (() -> Void) -> Void  {
    
    return { (completion: () -> Void) in
        
        let value = lhs()
        
        rhs(value, completion)
    }
}

// producer, async transformer

public func |> <T, U>(lhs: () -> T, rhs: (T, (U) -> Void) -> Void) -> ((U) -> Void) -> Void  {
    
    return { (completion: (U) -> Void) in
        
        let value = lhs()
        
        rhs(value, completion)
    }
}

// async producer, consumer

public func |> <T>(lhs: ((T) -> Void) -> Void, rhs: T -> Void) -> (() -> Void) -> Void  {
    
    return { (completion: () -> Void) in
        
        lhs() { (value: T) in
            
            rhs(value)
            
            completion()
        }
    }
}

// async producer, async consumer

public func |> <T>(lhs: ((T) -> Void) -> Void, rhs: (T, () -> Void) -> Void) -> (() -> Void) -> Void  {
    
    return { (completion: () -> Void) in
        
        lhs() { (value: T) in
            
            rhs(value, completion)
        }
    }
}

// async producer, transformer

//public func |> <T, U>(lhs: ((T) -> Void) -> Void, rhs: T -> U) -> ((U) -> Void) -> Void  {
//    
//    return { (completion: (U) -> Void) in
//        
//        lhs() { (value: T) in
//            
//            let newValue = rhs(value)
//            
//            completion(newValue)
//        }
//    }
//}



func toString<T>(value: T) -> String {
    
    return "\(value)"
}

func asyncThunkify<T>(value: T) -> (T -> Void) -> Void {
    
    return { completion in
        
        return completion(value)
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

// async transformer, sync consumer

public func |> <T, U>(lhs: (T, (U) -> Void) -> Void, rhs: U -> Void) -> (T, () -> Void) -> Void  {
    
    return { (value: T, completion: () -> Void) in
        
        lhs(value) { (newValue: U) in
            
            rhs(newValue)
            
            completion()
        }
    }
}

// async transformer, async consumer

public func |> <T, U>(lhs: (T, (U) -> Void) -> Void, rhs: (U, () -> Void) -> Void) -> (T, () -> Void) -> Void  {
    
    return { (value: T, completion: () -> Void) in
        
        lhs(value) { (newValue: U) in
            
            rhs(newValue, completion)
        }
    }
}

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


// MARK: Consumers
