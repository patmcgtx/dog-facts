//
//  DogFactsServiceMock.swift
//  DogFactsTests
//
//  Created by Patrick McGonigle on 5/14/22.
//

import Foundation
@testable import DogFacts

/// Mockable version of `DogFactsService` for local testing
class DogFactsServiceMocked: DogFactsService {
    
    /// The data to return in `fetch()`, if any
    var mockedFact: String?

    /// The error to throw in `fetch()`, if any
    var mockedError: Error? = nil

    func fetchDogFact() async throws -> String {
        if let error = self.mockedError {
            throw error
        } else if let fact = self.mockedFact {
            return fact
        } else {
            throw DogFactsError.noResponse
        }
    }
    
}
