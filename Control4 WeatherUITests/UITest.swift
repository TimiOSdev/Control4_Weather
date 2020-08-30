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
    
}
