//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by miles on 13/12/2016.
//  Copyright © 2016 deveint. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    //Confirm that the Meal initializer returns a Meal object when passed valid parameters
    func testMealInitializationSucceeds(){
        //Zero rating
        let zeroRating =  Meal.init(name: "Zero",photo: nil, rating: 0)
        XCTAssertNotNil(zeroRating)
        
        //Highest positive rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    //Confirm that the Meal initializer returns nil when passed a negative rating or an empty name
    func testMealInitializationFails(){
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        //Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        //Empty string  
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
    }
}
