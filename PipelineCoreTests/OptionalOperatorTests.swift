//
//  OptionalOperatorTests.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/8/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import XCTest
import PipelineCore

class OptionalOperatorTests: XCTestCase {
    
    // MARK: Producers
    
    // producer, consumer
    
    func testSomeProducerConsumer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFive = optionalThunkify(5) ?> expect(expt, 5)
        
        expectFive()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testNilProducerConsumer() {
        
        let produceNil = nilThunk ?> failTest
        
        produceNil()
    }
    
    // producer, transformer
    
    func testSomeProducerTransformer() {
        
        let addFiveOptional = optionalThunkify(0) ?> addFive
        
        let result = addFiveOptional()
        
        XCTAssertNotNil(result)
        
        XCTAssert(result == 5)
    }
    
    func testNilProducerTransformer() {
        
        let addFiveToNil = nilThunk ?> addFive
        
        XCTAssertNil(addFiveToNil())
    }
    

    // MARK: Transformers

    // transformer, consumer
    
    func testSomeTransformerConsumer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFive = stringToInt ?> expect(expt, 5)
        
        expectFive("5")
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testNilTransformerConsumer() {
        
        let expectNil = transformToNil ?> failTest
        
        XCTAssertNil(expectNil(0))
    }

    // transformer, transformer
    
    func testSomeTransformerTransformer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFiveString = stringToInt ?> toString ?> expect(expt, "5")
        
        expectFiveString("5")
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testNilTransformerTransformer() {
        
        let expectNil = stringToInt ?> addFive ?> failTest
        
        XCTAssertNil(expectNil("not a number"))
    }
    

    // MARK: Consumers
    
    // consumer, producer
    
    func testOptionalConsumerProducer() {
        
        let firstExpt = expectationWithDescription("first consumer")
        
        let secondExpt = expectationWithDescription("second consumer")
        
        let consumeThenProduce = optionalThunkify(5)
            ?> expect(firstExpt, 5)
            |> thunkify("abc")
            |> expect(secondExpt, "abc")
        
        consumeThenProduce()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
