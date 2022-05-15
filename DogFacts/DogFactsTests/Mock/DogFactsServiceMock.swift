//
//  DogFactsServiceMock.swift
//  DogFactsTests
//
//  Created by Patrick McGonigle on 5/14/22.
//

import Foundation
@testable import DogFacts

/// Mockable version of `DogFactsService` for local testing
class DogFactsServiceMock: DogFactsService {
    
    /// The data to return in `fetch()`, if any
    var resultingFact: String?

    /// The error to throw in `fetch()`, if any
    var resultingError: Error? = nil

    func fetchDogFact() async throws -> String {
        if let error = self.resultingError {
            throw error
        } else if let fact = self.resultingFact {
            return fact
        } else {
            throw DogFactsError.noResponse
        }
    }
    
}
