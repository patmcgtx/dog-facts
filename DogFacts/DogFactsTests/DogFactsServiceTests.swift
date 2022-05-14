//
//  DogFactsServiceTests.swift
//  DogFactsTests
//
//  Created by Patrick McGonigle on 5/5/22.
//

import XCTest
@testable import DogFacts

class DogFactsServiceTests: XCTestCase {

    private var dataFetcher: MockDogFactsDataFetcher?
    private var service: DogFactsService?
    
    override func setUp() async throws {
        self.dataFetcher = MockDogFactsDataFetcher()
        if let fetcher = self.dataFetcher {
            self.service = LiveDogFactsService(dataFetcher: fetcher)
        }
    }

    func testGoodResponse() async throws {
        
        let fact = "The earliest dog fossil dates back to nearly 10,000 B.C."
        let json = "{\"facts\":[\"\(fact)\"],\"success\":true}"
        
        self.dataFetcher?.set(response: json)
        
        let result = try await self.service?.dogFact
        XCTAssertEqual(result, fact)
    }

    func testEmptyResponse() async throws {
        
        do {
            let _ = try await self.service?.dogFact
            XCTFail("Unexpected success")
        } catch {
            XCTAssertNotNil(error as? DecodingError)
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
    }

    func testInvalidResponse() async throws {
        
        let json = "{\"invalid\":\"true\"}"
        self.dataFetcher?.set(response: json)
        
        do {
            let _ = try await self.service?.dogFact
            XCTFail("Unexpected success")
        } catch is DecodingError {
            print("Got decoding error as expected")
        } catch {
            XCTFail("Unexpected error type")
        }
    }

    func testThrows() async throws {
        
        self.dataFetcher?.resultingError = DogFacts.Errors.badURL
        
        do {
            let _ = try await self.service?.dogFact
            XCTFail("Unexpected success")
        } catch DogFacts.Errors.badURL {
            print("Got badURL error as expected")
        } catch {
            XCTFail("Unexpected error type")
        }
    }

}
