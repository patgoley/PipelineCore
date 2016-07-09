//
//  OptionalOperators.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/8/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import Foundation

// transformer, transformer

public func ?> <T, U, V>(lhs: T -> U?, rhs: U -> V) -> T -> V?  {
    
    return { value in
        
        if let transformed = lhs(value) {
            
            return rhs(transformed)
        }
        
        return nil
    }
}

// optional consumer, producer

public func ?> <T>(lhs: () -> T?, rhs: (T) -> Void) -> () -> Void  {
    
    return { value in
        
        if let val = lhs() {
            
            rhs(val)
        }
    }
}

// MARK: Async

// sync producer, async consumer

public func ?> <T>(lhs: () -> T?, rhs: (T, () -> Void) -> Void) -> (() -> Void) -> Void  {
    
    return { (completion: () -> Void) in
        
        if let value = lhs() {
            
            rhs(value, completion)
        }
        
        completion()
    }
}