//
//  AsyncFunctionOperatorTests.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import XCTest
import PipelineCore

class AsyncFunctionOperatorTests: XCTestCase {
    
    // MARK: Producers
    
    // producer, async consumer
    
    func testProducerAsyncConsumer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFive = thunkify(5) |> asyncExpect(expt, 5)
        
        expectFive() {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    func testProducerAsyncTransformer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFive = thunkify(5) |> asyncToString |> expect(expt, "5")
        
        expectFive() {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // async producer, sync consumer
    
    func testAsyncProducerConsumer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFive = asyncThunkify(5) |> expect(expt, 5)
        
        expectFive() {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // async producer, async consumer
    
    func testAsyncProducerAsyncConsumer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFive = asyncThunkify(5) |> asyncExpect(expt, 5)
        
        expectFive() {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // async producer, transformer
    
    func testAsyncProducerTransformer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let fiveToString = asyncThunkify(5) |> toString
        
        fiveToString() { (str: String) -> Void in
            
            print("got a cool str")
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // async producer, async transformer
    
    func testAsyncProducerAsyncTransformer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let fiveToString = asyncThunkify(5) |> asyncToString
        
        fiveToString() { (str: String) -> Void in
            
            print("got a cool str")
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    

    // MARK: Transformers
    
    // async transformer, sync consumer
    
    func testAsyncTransformerSyncConsumer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFiveMore = asyncAddFive |> expect(expt, 5)
        
        expectFiveMore(0) {
        
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // async transformer, async consumer
    
    func testAsyncTransformerAsyncConsumer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFiveMore = asyncAddFive |> asyncExpect(expt, 5)
        
        expectFiveMore(0) {
        
        
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // async transformer, sync transformer
    
    func testAsyncTransformerTransformer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFiveMoreString = asyncAddFive |> toString
        
        expectFiveMoreString(0) { (str: String) in
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // async transformer, async transformer
    
    func testAsyncTransformerAsyncTransformer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFiveMoreString: (Int, (String) -> Void) -> Void = asyncAddFive |> asyncToString
        
        expectFiveMoreString(0) { str in
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // sync transformer, async consumer
    
    func testSyncTransformerAsyncConsumer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFiveMoreString = addFive |> asyncExpect(expt, 5)
        
        expectFiveMoreString(0) {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // sync transformer, async transformer
    
    func testSyncTransformerAsyncTransformer() {
        
        let expt = expectation(withDescription: "consumer")
        
        let expectFiveMoreString: (Int, (String) -> Void) -> Void = addFive |> asyncToString
        
        expectFiveMoreString(0) { str in
            
            XCTAssert(str == "5")
            
            expt.fulfill()
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    

    // MARK: Consumers
    
    // async consumer, producer
    
    func testAsyncConsumerProducer() {
        
        let firstExpt = expectation(withDescription: "first consumer")
        
        let secondExpt = expectation(withDescription: "second consumer")
        
        let consumeThenProduce = addFive
            |> asyncExpect(firstExpt, 5)
            |> thunkify("abc")
            |> expect(secondExpt, "abc")
        
        consumeThenProduce(0) {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // async consumer, async producer
    
    func testAsyncConsumerAsyncProducer() {
        
        let firstExpt = expectation(withDescription: "first consumer")
        
        let secondExpt = expectation(withDescription: "second consumer")
        
        let consumeThenProduce = addFive
            |> asyncExpect(firstExpt, 5)
            |> asyncThunkify("abc")
            |> expect(secondExpt, "abc")
        
        consumeThenProduce(0) {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
    
    // consumer, async producer
    
    func testConsumerAsyncProducer() {
        
        let firstExpt = expectation(withDescription: "first consumer")
        
        let secondExpt = expectation(withDescription: "second consumer")
        
        let consumeThenProduce = addFive
            |> expect(firstExpt, 5)
            |> asyncThunkify("abc")
            |> expect(secondExpt, "abc")
        
        consumeThenProduce(0) {
            
            
        }
        
        waitForExpectations(withTimeout: 0.1, handler: nil)
    }
}
