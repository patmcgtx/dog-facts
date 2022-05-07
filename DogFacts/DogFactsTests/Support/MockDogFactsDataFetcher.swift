//
//  MockDogFactsDataFetcher.swift
//  DogFactsUITests
//
//  Created by Patrick McGonigle on 5/6/22.
//

import Foundation
@testable import DogFacts

class MockDogFactsDataFetcher: DogFactsDataFetcher {

    var urlPath: String = ""
    
    /// The data to return in `fetch()`, if any
    var resultingData: Data? = nil

    /// The error to throw in `fetch()`, if any
    var resultingError: Error? = nil
    
    /// Convenient way to set the response data as a string
    func set(response: String) {
        self.resultingData = response.data(using: .utf8)
    }
    
    /**
     Returns a mock response.
     - If `resultingError` is set, then it is thrown in the response.
     - Otherwise, if `resultingData` is set, then it is returned.
     - If neither are set, then empty data is returned.
     */
    func fetch() async throws -> Data {
        
        if let error = self.resultingError {
            throw error
        } else if let data = self.resultingData {
            return data
        } else {
            return Data()
        }
    }
    
}
