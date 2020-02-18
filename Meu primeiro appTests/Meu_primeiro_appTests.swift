//
//  Meu_primeiro_appTests.swift
//  Meu primeiro appTests
//
//  Created by Jonathan on 28/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import XCTest
@testable import Meu_primeiro_app

class Meu_primeiro_appTests: XCTestCase {
    
//MARK: Meal Class Tests
    
    func testMealInitializationSucceeds() {
        
        let zeroRatingMeal = Bar.init(name: "Zero", photo: nil, rating: 0, latitude: 1, longitude: 2, telefone: "nao", endereco: "Rua")
        XCTAssertNotNil(zeroRatingMeal)
        
        let positiveRatingMeal = Bar.init(name: "Positive", photo: nil, rating: 5, latitude: 1, longitude: 2, telefone: "sim",  endereco: "Rua")
        XCTAssertNotNil(positiveRatingMeal)
        
        let positiveTelefoneMeal = Bar.init(name: "positive", photo: nil, rating: 5, latitude: 1, longitude: 2, telefone: "+55 47 99242-0449",  endereco: "Rua" )
        XCTAssertNotNil(positiveTelefoneMeal)
        
        
    }
 
    func testMealInitializationFails() {
        
        let negativeRatingMeal = Bar.init(name: "Negative", photo: nil, rating: -1, latitude: 0, longitude: -2, telefone: "nao",  endereco: "Rua")
        XCTAssertNil(negativeRatingMeal)
        
        let largeRatingMeal = Bar.init(name: "Large", photo: nil, rating: 6, latitude: 9, longitude: 8, telefone: "yes",  endereco: "Rua")
        XCTAssertNil(largeRatingMeal)
        
        let emptyStringMeal = Bar.init(name: "", photo: nil, rating: 0, latitude: 1, longitude: 2, telefone: "sim",  endereco: "Rua")
        XCTAssertNil(emptyStringMeal)
        
        let negativeTelefoneMeal = Bar.init(name: "positive", photo: nil, rating: 5, latitude: 1, longitude: 2, telefone: "+55 47 99242-0445559",  endereco: "Rua")
        XCTAssertNil(negativeTelefoneMeal)
    }
}
