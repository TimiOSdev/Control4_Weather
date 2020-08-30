//
//  Control4_WeatherTests.swift
//

import XCTest
@testable import Control4_Weather
class Control4_WeatherTests: XCTestCase {
var app: WeatherDetailVC!
    override func setUpWithError() throws {
        app = WeatherDetailVC()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testConvertIntoFahrenheit_Temperature_ShouldReturnTrue() throws {
        let fahrenheitWillBe90Degrees = app.convertIntoFahrenheit(temp: 305.33)
        XCTAssertEqual(fahrenheitWillBe90Degrees, "90°", "This should Pass it should be 90° if you change the argument it will change the outcome")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
