//
//  DogFacts.swift
//  DocFactsMac
//
//  Created by Patrick McGonigle on 5/4/22.
//

import Foundation

/// Errors used throughout the app
enum DogFactsError: Error {
    case badURL
    case noResponse
}

/// Protocol for fetching dog facts
protocol DogFactsService {
    
    /**
     Fetches a new dog fact.
     - Returns: A dog fact as a string
     */
    func fetchDogFact() async throws -> String
}

/// Fetches dog fact raw data
protocol DogFactsDataFetcher {
    
    /// The URL to get the raw dog fact data from
    var urlPath: String { get set }
    
    /**
     The async/await version 🤩
     - Returns: Raw dog fact data
     */
    func fetch() async throws -> Data
 }

