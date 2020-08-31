//
//  UITest.swift
//  Control4 WeatherUITests
//
//  Created by Tim on 8/30/20.
//  Copyright © 2020 Tim. All rights reserved.
//

import XCTest
class UITest: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testStartOfApp() throws {
        XCTAssert(app.staticTexts["San Francisco"].exists)
    }
    
    
    func testSwipeUpToPickSaltLakeCity() throws {
        let pickerWheel = app.pickerWheels["San Francisco"]
        pickerWheel.adjust(toPickerWheelValue: "Salt Lake City")
        XCTAssert(app.staticTexts["Salt Lake City"].exists)
    }
    
    func testSwipeUpToPickNewYork() throws {
        let pickerWheel = app.pickerWheels["San Francisco"]
        pickerWheel.adjust(toPickerWheelValue: "New York")
        XCTAssert(app.staticTexts["New York"].exists)
    }
    
    func testNewCityAdded() throws {
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Add City"]/*[[".buttons[\"Add City\"].staticTexts[\"Add City\"]",".staticTexts[\"Add City\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element.tap()
        app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.keys["S"].tap()
        app.keys["e"].tap()
        app.keys["a"].tap()
        app.keys["t"].tap()
        app.keys["t"].tap()
        app.keys["l"].tap()
        app.keys["e"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["add City"].tap()
        
       let pickerWheel = app.pickerWheels["San Francisco"]
       pickerWheel.adjust(toPickerWheelValue: "Seattle")
       XCTAssert(app.staticTexts["Seattle"].exists)
    }
    
}
