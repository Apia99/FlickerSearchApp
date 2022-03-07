//
//  FlickerSearchAppTests.swift
//  FlickerSearchAppTests
//
//  Created by Admin on 03/03/2022.
//

import XCTest
@testable import FlickerSearchApp

class FlickerSearchAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearch() throws {
        let viewController = ViewController()
        let fakeURLSession = FakeURLSession()
        fakeURLSession.data = Data()
        viewController.setURLSession(fakeURLSession)
        viewController.searchOnFlickr("kittens")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
