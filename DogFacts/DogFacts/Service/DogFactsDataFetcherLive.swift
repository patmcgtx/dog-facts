//
//  DogFactsDataFetcherLive.swift
//  DocFactsMac
//
//  Created by Patrick McGonigle on 5/4/22.
//

import Foundation

/// Fetches dog facts raw data from a live network endpoint
class DogFactsDataFetcherLive: DogFactsDataFetcher {
    
    var urlPath: String = ""    
    private let urlSession = URLSession.shared
    
    // MARK: DogFactsDataFetcher
    
    func fetch() async throws -> Data {
        if let url = URL(string: self.urlPath) {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } else {
            throw DogFactsError.badURL
        }
    }
    
}
