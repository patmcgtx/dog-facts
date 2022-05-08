//
//  DogFactsUITestsLaunchTests.swift
//  DogFactsUITests
//
//  Created by Patrick McGonigle on 5/5/22.
//

import XCTest

class DogFactsUITestsLaunchTests: XCTestCase {

    private let app = XCUIApplication()
    private var mainWindow: XCUIElement?
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        
        continueAfterFailure = false
        
        self.app.launch()
        
        self.mainWindow = app.windows.firstMatch
        XCTAssertNotNil(self.mainWindow)
        
        // TODO patmcg set up mock data
    }

    func testLaunch() throws {
        
        guard let window = self.mainWindow else {
            XCTFail("Failed to get window")
            return
        }
        
        let fetchButton = window.buttons.firstMatch
        XCTAssert(fetchButton.waitForExistence(timeout: 2.0))
        XCTAssertEqual(fetchButton.title, "Fetch 🐶")
        XCTAssert(fetchButton.isEnabled)
        
        let factText = window.staticTexts.firstMatch
        XCTAssert(factText.waitForExistence(timeout: 2.0))
        XCTAssertEqual(factText.value as? String, "In 1957, Laika became the first living being in space via an earth satellite and JFK’s terrier, Charlie, fathered 4 puppies with Laika’s daughter.")
    }

    func testFetch() throws {
        
        guard let window = self.mainWindow else {
            XCTFail("Failed to get window")
            return
        }
        
        let fetchButton = window.buttons.firstMatch
        XCTAssert(fetchButton.waitForExistence(timeout: 2.0))

        let factText = window.staticTexts.firstMatch
        XCTAssert(factText.waitForExistence(timeout: 2.0))
        
        let initialFact = factText.value as? String
        XCTAssertNotNil(initialFact)

        XCTAssertTrue(fetchButton.isEnabled)
        fetchButton.click()
        XCTAssertFalse(fetchButton.isEnabled)
        
        // TODO patmcg wait for the fact to change
    }

}
