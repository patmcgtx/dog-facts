//
//  DogFactsServiceTests.swift
//  DogFactsTests
//
//  Created by Patrick McGonigle on 5/5/22.
//

import XCTest
@testable import DogFactsSwiftUI

class DogFactsServiceTests: XCTestCase {

    // These are optional because they're initialized in `setUp()`
    private var mockFetcher: DogFactsDataFetcherMocked?
    private var service: DogFactsService?
    
    override func setUp() async throws {
        self.mockFetcher = DogFactsDataFetcherMocked()
        guard let mockDataFetcher = self.mockFetcher else { XCTFail("Failed to get mock fetcher"); return }
        self.service = DogFactsServiceFetched(dataFetcher: mockDataFetcher)
    }

    func testGoodResponse() async throws {
        
        let fact = "The earliest dog fossil dates back to nearly 10,000 B.C."
        let json = "{\"facts\":[\"\(fact)\"],\"success\":true}"
        
        self.mockFetcher?.apply(response: json)
        
        let result = try await self.service?.fetchDogFact()
        XCTAssertEqual(result, fact)
    }

    func testEmptyResponse() async throws {
        
        self.mockFetcher?.apply(response: "")

        do {
            let _ = try await self.service?.fetchDogFact()
            XCTFail("Unexpected success")
        } catch {
            XCTAssertNotNil(error as? DecodingError)
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
    }

    func testInvalidResponse() async throws {
        
        let json = "{\"invalid\":\"true\"}"
        self.mockFetcher?.apply(response: json)
        
        do {
            let _ = try await self.service?.fetchDogFact()
            XCTFail("Unexpected success")
        } catch is DecodingError {
            print("Got decoding error as expected")
        } catch {
            XCTFail("Unexpected error type")
        }
    }

    func testThrows() async throws {
        
        self.mockFetcher?.mockedError = DogFactsSwiftUI.DogFactsError.badURL
        
        do {
            let _ = try await self.service?.fetchDogFact()
            XCTFail("Unexpected success")
        } catch DogFactsSwiftUI.DogFactsError.badURL {
            print("Got badURL error as expected")
        } catch {
            XCTFail("Unexpected error type")
        }
    }

}
