//
//  DogFactsDataFetcherLive.swift
//  DocFactsMac
//
//  Created by Patrick McGonigle on 5/4/22.
//

import Foundation

/// Fetches dog facts raw data from a live network endpoint
class DogFactsDataFetcherNetwork: DogFactsDataFetcher {
    
    func fetch() async throws -> Data {
        if let url = URL(string: "https://dog-api.kinduff.com/api/facts") {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } else {
            throw DogFactsError.badURL
        }
    }
    
}
