//
//  DogFacts.swift
//  DocFactsMac
//
//  Created by Patrick McGonigle on 5/4/22.
//

import Foundation

/// Fetches dog fact raw data
protocol DogFactsDataFetcher {
    
    /// The URL to get the raw dog fact data from
    var urlPath: String { get set }
    
    /**
     Old-school completion handler fetching
     - Parameter completion: Closure to execute when the fetch attempt completes, indicating success or failure.
     */
    func fetchData(completion: @escaping (Result<Data, Error>) -> ())
    
    /**
     The async/await  version 🤩
     - Returns: Raw dog fact data
     */
    func fetch() async throws -> Data
 }

enum Errors: Error {
    case badURL
    case noResponse
}
