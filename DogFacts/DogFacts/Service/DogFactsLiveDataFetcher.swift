//
//  DogFactsDataFetcher.swift
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
     The async/await version 🤩
     - Returns: Raw dog fact data
     */
    func fetch() async throws -> Data
 }

/// Fetches dog facts raw data from a live network endpoint
class DogFactsLiveDataFetcher: DogFactsDataFetcher {
    
    var urlPath: String = ""
    
    private let urlSession = URLSession.shared
    
    /// async/await  version 🤩
    func fetch() async throws -> Data {
        if let url = URL(string: self.urlPath) {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } else {
            throw Errors.badURL
        }
    }
    
}
