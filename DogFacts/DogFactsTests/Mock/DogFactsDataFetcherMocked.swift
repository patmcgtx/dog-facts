//
//  DogFactsDataFetcherMock.swift
//  DogFactsUITests
//
//  Created by Patrick McGonigle on 5/6/22.
//

import Foundation
@testable import DogFacts

/// A mockable version of a `DogFactsDataFetcher` for local testing
class DogFactsDataFetcherMocked: DogFactsDataFetcher {

    /// The data to return in `fetch()`, if any
    var mockedData: Data? = nil

    /// The error to throw in `fetch()`, if any
    var mockedError: Error? = nil
    
    /// Convenient way to set the response data as a string
    func apply(response: String) {
        self.mockedData = response.data(using: .utf8)
    }
    
    /**
     Returns a mock response.
     - If `resultingError` is set, then it is thrown in the response.
     - Otherwise, if `resultingData` is set, then it is returned.
     - If neither are set, then empty data is returned.
     */
    func fetch() async throws -> Data {        
        if let error = self.mockedError {
            throw error
        } else if let data = self.mockedData {
            return data
        } else {
            throw DogFactsError.noResponse
        }
    }
    
}
