//
//  AsyncFunctionOperatorTests.swift
//  HighOrder
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import XCTest
import HighOrder

class AsyncFunctionOperatorTests: XCTestCase {
    
    // MARK: Producers
    
    // producer, async consumer
    
    func testProducerAsyncConsumer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFive = thunkify(5) |> asyncConsumer(expt, 5)
        
        expectFive() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func testProducerAsyncTransformer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFive = thunkify(5) |> asyncToString |> consumer(expt, "5")
        
        expectFive() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // async producer, consumer
    
    func testAsyncProducerConsumer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFive = asyncThunkify(5) |> consumer(expt, 5)
        
        expectFive() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // async producer, async consumer
    
    func testAsyncProducerAsyncConsumer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFive = asyncThunkify(5) |> asyncConsumer(expt, 5)
        
        expectFive() {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // async producer, transformer
    
    func testAsyncProducerTransformer() {
        
        let expt = expectationWithDescription("consumer")
        
        let fiveToString: ((String) -> Void) -> Void = asyncThunkify(5) |> toString
        
        fiveToString() { (str: String) -> Void in
            
            print("got a cool str")
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // async producer, async transformer
    
    func testAsyncProducerAsyncTransformer() {
        
        let expt = expectationWithDescription("consumer")
        
        let fiveToString = asyncThunkify(5) |> asyncToString
        
        fiveToString() { (str: String) -> Void in
            
            print("got a cool str")
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    

    // MARK: Transformers
    
    // async transformer, consumer
    
    func testAsyncTransformerConsumer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFiveMore = asyncAddFive |> consumer(expt, 5)
        
        expectFiveMore(0) { }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // async transformer, async consumer
    
    func testAsyncTransformerAsyncConsumer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFiveMore = asyncAddFive |> asyncConsumer(expt, 5)
        
        expectFiveMore(0) { }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // async transformer, transformer
    
    func testAsyncTransformerTransformer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFiveMoreString = asyncAddFive |> toString
        
        expectFiveMoreString(0) { (str: String) in
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // async transformer, async transformer
    
    func testAsyncTransformerAsyncTransformer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFiveMoreString: (Int, (String) -> Void) -> Void = asyncAddFive |> asyncToString
        
        expectFiveMoreString(0) { str in
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // transformer, async transformer
    
    func testTransformerAsyncTransformer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFiveMoreString: (Int, (String) -> Void) -> Void = addFive |> asyncToString
        
        expectFiveMoreString(0) { str in
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    

    // MARK: Consumers
    
    // async consumer, producer
    
    func testAsyncConsumerProducer() {
        
        let firstExpt = expectationWithDescription("first consumer")
        
        let secondExpt = expectationWithDescription("second consumer")
        
        let consumeThenProduce = addFive
            |> asyncConsumer(firstExpt, 5)
            |> thunkify("abc")
            |> consumer(secondExpt, "abc")
        
        consumeThenProduce(0) {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // async consumer, async producer
    
    func testAsyncConsumerAsyncProducer() {
        
        let firstExpt = expectationWithDescription("first consumer")
        
        let secondExpt = expectationWithDescription("second consumer")
        
        let consumeThenProduce = addFive
            |> asyncConsumer(firstExpt, 5)
            |> asyncThunkify("abc")
            |> consumer(secondExpt, "abc")
        
        consumeThenProduce(0) {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    // consumer, async producer
    
    func testConsumerAsyncProducer() {
        
        let firstExpt = expectationWithDescription("first consumer")
        
        let secondExpt = expectationWithDescription("second consumer")
        
        let consumeThenProduce = addFive
            |> consumer(firstExpt, 5)
            |> asyncThunkify("abc")
            |> consumer(secondExpt, "abc")
        
        consumeThenProduce(0) {
            
            
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
