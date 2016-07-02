//
//  ThrowingFunctionOperators.swift
//  HighOrder
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import Foundation


// MARK: Producers

// throwing producer, consumer

public func !> <T>(lhs: () throws -> T, rhs: T -> ()) -> () -> ErrorType?  {
    
    return {
        
        do {
            
            let value = try lhs()
            
            rhs(value)
            
            return nil
            
        } catch let error {
            
            return error
        }
    }
}

// producer, thowing consumer

public func !> <T>(lhs: () -> T, rhs: T throws -> ()) -> () -> ErrorType?  {
    
    return {
        
        do {
            
            let value = lhs()
            
            try rhs(value)
            
            return nil
            
        } catch let error {
            
            return error
        }
    }
}

// throwing producer, thowing consumer

public func !> <T>(lhs: () throws -> T, rhs: T throws -> ()) -> () -> ErrorType?  {
    
    return {
        
        do {
            
            let value = try lhs()
            
            try rhs(value)
            
            return nil
            
        } catch let error {
            
            return error
        }
    }
}

// producer, throwing transformer

public func !> <T, U>(lhs: () -> T, rhs: T throws -> U) -> () -> Result<U>  {
    
    return {
        
        do {
            
            let value = lhs()
            
            let result = try rhs(value)
            
            return .Success(result)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}

// throwing producer, transformer

public func !> <T, U>(lhs: () throws -> T, rhs: T -> U) -> () -> Result<U>  {
    
    return {
        
        do {
            
            let value = try lhs()
            
            let result = rhs(value)
            
            return .Success(result)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}

// throwing producer, throwing transformer

public func !> <T, U>(lhs: () throws -> T, rhs: T  throws -> U) -> () -> Result<U>  {
    
    return {
        
        do {
            
            let value = try lhs()
            
            let result = try rhs(value)
            
            return .Success(result)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}


// MARK: Transformers

// transformer, throwing consumer

public func !> <T, U>(lhs: T -> U, rhs: U throws -> Void) -> T -> ErrorType?  {
    
    return { value in
        
        do {
            
            let transformed = lhs(value)
            
            try rhs(transformed)
            
            return nil
            
        } catch let error {
            
            return error
        }
    }
}

// throwing transformer, consumer

public func !> <T, U>(lhs: T throws -> U, rhs: U -> Void) -> T -> ErrorType?  {
    
    return { value in
        
        do {
            
            let transformed = try lhs(value)
            
            rhs(transformed)
            
            return nil
            
        } catch let error {
            
            return error
        }
    }
}

// throwing transformer, throwing consumer

public func !> <T, U>(lhs: T throws -> U, rhs: U throws -> Void) -> T -> ErrorType?  {
    
    return { value in
        
        do {
            
            let transformed = try lhs(value)
            
            try rhs(transformed)
            
            return nil
            
        } catch let error {
            
            return error
        }
    }
}

// transformer, throwing transformer

public func !> <T, U, V>(lhs: T -> U, rhs: U throws -> V) -> T -> Result<V>  {
    
    return { value in
        
        do {
            
            let newValue = lhs(value)
            
            let result = try rhs(newValue)
            
            return .Success(result)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}

// throwing transformer, transformer

public func !> <T, U, V>(lhs: T throws -> U, rhs: U -> V) -> T -> Result<V>  {
    
    return { value in
        
        do {
            
            let newValue = try lhs(value)
            
            let result = rhs(newValue)
            
            return .Success(result)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}

// throwing transformer, throwing transformer

public func !> <T, U, V>(lhs: T throws -> U, rhs: U throws -> V) -> T -> Result<V>  {
    
    return { value in
        
        do {
            
            let newValue = try lhs(value)
            
            let result = try rhs(newValue)
            
            return .Success(result)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}


// MARK: Consumers

// consumer, throwing producer

public func !> <T, U>(lhs: T -> (), rhs: () throws -> U) -> T -> Result<U>  {
    
    return { value in
        
        do {
            
            lhs(value)
            
            let newValue = try rhs()
            
            return .Success(newValue)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}

// throwing consumer, producer

public func !> <T, U>(lhs: T throws -> (), rhs: () -> U) -> T -> Result<U>  {
    
    return { value in
        
        do {
            
            try lhs(value)
            
            let newValue = rhs()
            
            return .Success(newValue)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}

// throwing consumer, throwing producer

public func !> <T, U>(lhs: T throws -> (), rhs: () throws -> U) -> T -> Result<U>  {
    
    return { value in
        
        do {
            
            try lhs(value)
            
            let newValue = try rhs()
            
            return .Success(newValue)
            
        } catch let error {
            
            return .Error(error)
        }
    }
}


