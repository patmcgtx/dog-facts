//
//  DogFactsUITests.swift
//  DogFactsUITests
//
//  Created by Patrick McGonigle on 5/5/22.
//

import XCTest

class DogFactsUITests: XCTestCase {

    private let app = XCUIApplication()
    private let timeout = 5.0
    private var mainWindow: XCUIElement?
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        
        continueAfterFailure = false
        
        self.app.launch()
        
        self.mainWindow = app.windows.firstMatch
        XCTAssertNotNil(self.mainWindow)
    }

    func testLaunch() throws {
        
        guard let window = self.mainWindow else {
            XCTFail("Failed to get window")
            return
        }
        
        // Confirm the fetch button
        let fetchButton = window.buttons.firstMatch
        XCTAssert(fetchButton.waitForExistence(timeout: timeout))
        XCTAssertEqual(fetchButton.title, "Fetch 🐶")
        XCTAssert(fetchButton.isEnabled)
        
        // Confirm the initial dog fact
        let factText = window.staticTexts.firstMatch
        XCTAssert(factText.waitForExistence(timeout: timeout))
        XCTAssertEqual(factText.value as? String, "In 1957, Laika became the first living being in space via an earth satellite and JFK’s terrier, Charlie, fathered 4 puppies with Laika’s daughter.")
    }

    func testFetch() throws {
                
        // TODO patmcg set up mock data

        guard let window = self.mainWindow else {
            XCTFail("Failed to get window")
            return
        }
        
        // Get the fetch button
        let fetchButton = window.buttons.firstMatch
        XCTAssert(fetchButton.waitForExistence(timeout: timeout))

        // Get the initial dog fact
        let dogFactLabel = window.staticTexts.firstMatch
        XCTAssert(dogFactLabel.waitForExistence(timeout: timeout))
        let initialDogFact = dogFactLabel.value as? String
        XCTAssertNotNil(initialDogFact)

        // Click the fetch button, confirming state before and after
        XCTAssertTrue(fetchButton.isEnabled)
        fetchButton.click()
        XCTAssertFalse(fetchButton.isEnabled)
        
        // Wait to make sure the confirm button got re-enabled
        let buttonReenabledPredicate = NSPredicate(format: "isEnabled == true")
        let buttonReenabledExpectation = expectation(for: buttonReenabledPredicate, evaluatedWith: fetchButton, handler: nil)
        wait(for: [buttonReenabledExpectation], timeout: timeout)

        // Confirm that the dog fact changed
        let updatedDogFact = dogFactLabel.value as? String
        XCTAssertNotEqual(initialDogFact, updatedDogFact)
    }

}
