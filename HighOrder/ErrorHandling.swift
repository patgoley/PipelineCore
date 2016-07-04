//
//  ErrorHandling.swift
//  HighOrder
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import Foundation

/*
 A type expressing the result of a process with potential error cases.
 The value is either the resulting value or an ErrorType created in attempting
 to produce the result.
*/

public enum Result<T> {
    
    public typealias ValueType = T
    
    case Success(T), Error(ErrorType)
}

/*
 Converts a throwing synchronous function into one that returns
 a `Result<U>` instead. Wrapping throwing functions with errorMap
 will allow them to be used with the `|>` operator.
*/

public func errorMap<T, U>(function: (T) throws -> U) -> (T) -> Result<U> {
    
    return { (value: T) -> Result<U> in
        
        do {
            
            let newValue = try function(value)
            
            return .Success(newValue)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}

/*
 Converts a throwing synchronous function into one that passes
 a `Result<U>` to the completion closure instead. 
 */

public func errorMap<T, U>(function: (T, (U) -> Void) throws -> Void) -> (T, (Result<U>) -> Void) -> Void {
    
    return { (value: T, completion: (Result<U>) -> Void) -> Void in
        
        do {
            
            try function(value) { (newValue: U) in
                
                completion(.Success(newValue))
            }
            
        } catch let error {
            
            completion(.Error(error))
        }
    }
}