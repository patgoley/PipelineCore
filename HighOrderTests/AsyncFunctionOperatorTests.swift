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
        
//        let expt = expectationWithDescription("consumer")
//        
//        let fiveToString = asyncThunkify(5) |> toString |> consumer(expt, "5")
//        
//        fiveToString() { (x: String) in
//         
//            XCTAssert(x == 5)
//        }
//        
//        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
//
//    // MARK: Transformers
//    
//    // transformer, consumer
//    
//    func testTransformerConsumer() {
//        
//        let expt = expectationWithDescription("consumer")
//        
//        let expectFiveMore = addFive |> consumer(expt, 5)
//        
//        expectFiveMore(0)
//        
//        waitForExpectationsWithTimeout(0.1, handler: nil)
//    }
//    
//    // transformer, transformer
//    
//    func testTransformerTransformer() {
//        
//        let expt = expectationWithDescription("consumer")
//        
//        let expectFiveMoreString = addFive |> toString |> consumer(expt, "5")
//        
//        expectFiveMoreString(0)
//        
//        waitForExpectationsWithTimeout(0.1, handler: nil)
//    }
//    
//    
//    // MARK: Consumers
//    
//    // consumer, producer
//    
//    func testConsumerProducer() {
//        
//        let firstExpt = expectationWithDescription("first consumer")
//        
//        let secondExpt = expectationWithDescription("second consumer")
//        
//        let consumeThenProduce = addFive
//            |> consumer(firstExpt, 5)
//            |> thunkify("abc")
//            |> consumer(secondExpt, "abc")
//        
//        consumeThenProduce(0)
//        
//        waitForExpectationsWithTimeout(0.1, handler: nil)
//    }
}
