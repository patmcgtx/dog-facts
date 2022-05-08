//
//  DogFactsUITestsLaunchTests.swift
//  DogFactsUITests
//
//  Created by Patrick McGonigle on 5/5/22.
//

import XCTest

class DogFactsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        
        // Launch
        let app = XCUIApplication()
        app.launch()
        
        let mainWindow = app.windows.firstMatch
        XCTAssert(mainWindow.waitForExistence(timeout: 2.0))
        
        let fetchButton = mainWindow.buttons.firstMatch
        XCTAssert(fetchButton.waitForExistence(timeout: 2.0))
        XCTAssertEqual(fetchButton.title, "Fetch 🐶")

        // Screenshot
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
