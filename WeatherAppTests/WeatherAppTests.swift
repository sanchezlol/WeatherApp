//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Alexandr on 3/3/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import XCTest
import MapKit
@testable import WeatherApp

class WeatherAppTests: XCTestCase, CLLocationManagerDelegate {
    
    
    override func setUp() {
        super.setUp()
//        weatherVCUnderTest
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func testCallToRemoteAPICompletes() {
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=37.785834&lon=-122.406417&appid=1813bf166bb7378f9a051c8f9a12009e")
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }.resume()
        

        waitForExpectations(timeout: 5, handler: nil)
        

        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testSavedCurrentWeatherForNil() {
        let mainWeatherItemUnderTest = WeatherModel.getCurrentWeather()
        XCTAssertNotNil(mainWeatherItemUnderTest)
    }
    
    func testSavedCurrentWeatherMainForNil() {
        let mainWeatherItemUnderTest = WeatherModel.getCurrentWeatherMain()
        XCTAssertNotNil(mainWeatherItemUnderTest)
    }
    func testUrlValidityForCurrentLocation() {
        let testLocationManager = CLLocationManager()
        guard let locValue: CLLocationCoordinate2D = testLocationManager.location?.coordinate else { return }
        let testLatitude = locValue.latitude
        let testLongitude = locValue.longitude
        
        let urlUnderTest = WeatherModel.generateUrl(latitude: testLatitude, longitude: testLongitude)
        
        
        URLSession.shared.dataTask(with: urlUnderTest!) { (data, response, error) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            XCTAssertEqual(statusCode, 200)
            
        }.resume()
        
    }
    
    
    
}
