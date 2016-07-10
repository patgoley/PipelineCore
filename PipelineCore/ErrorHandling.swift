//
//  ErrorHandling.swift
//  PipelineCore
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
    
    case success(T), error(ErrorProtocol)
}

/*
 Converts a throwing synchronous function into one that returns a `Result<U>` instead.
 A throwing async consumer produces an ErrorType? instead of a Result. Wrapping throwing 
 functions with errorMap will allow them to be used with the `|>` operator.
*/

// sync producer or transformer

public func errorMap<T, U>(_ function: (T) throws -> U) -> (T) -> Result<U> {
    
    return { (value: T) -> Result<U> in
        
        do {
            
            let newValue = try function(value)
            
            return .success(newValue)
            
        } catch let error {
            
            return .error(error)
        }
    }
}

// sync consumer

public func errorMap<T>(_ function: (T) throws -> Void) -> (T) -> ErrorProtocol? {
    
    return { (value: T) -> ErrorProtocol? in
        
        do {
            
            try function(value)
            
            return nil
            
        } catch let error {
            
            return error
        }
    }
}

/*
 Converts a throwing asynchronous function into one that passes a `Result<U>` to the completion 
 closure instead. A throwing async consumer produces an ErrorType? instead of a Result.
 */

// async producer

public func errorMap<U>(_ function: ((U) -> Void) throws -> Void) -> ((Result<U>) -> Void) -> Void {
    
    return { (completion: (Result<U>) -> Void) -> Void in
        
        do {
            
            try function() { (value: U) in
                
                completion(.success(value))
            }
            
        } catch let error {
            
            completion(.error(error))
        }
    }
}

// async transformer

public func errorMap<T, U>(_ function: (T, (U) -> Void) throws -> Void) -> (T, (Result<U>) -> Void) -> Void {
    
    return { (value: T, completion: (Result<U>) -> Void) -> Void in
        
        do {
            
            try function(value) { (newValue: U) in
                
                completion(.success(newValue))
            }
            
        } catch let error {
            
            completion(.error(error))
        }
    }
}

// async consumer

public func errorMap<U>(_ function: (U, () -> Void) throws -> Void) -> (U, (ErrorProtocol?) -> Void) -> Void {
    
    return { (value: U, completion: (ErrorProtocol?) -> Void) -> Void in
        
        do {
            
            try function(value) {
                
                completion(nil)
            }
            
        } catch let error {
            
            completion(error)
        }
    }
}
