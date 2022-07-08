//
//  DogFactsServiceFetched.swift
//  DocFactsMac
//
//  Created by Patrick McGonigle on 5/4/22.
//

import Foundation

/// Fetches dog facts and converts to a model.
struct DogFactsServiceFetched: DogFactsService {
    
    private let dataFetcher: DogFactsDataFetcher
    
    /// Creates a `DogFactsServiceLive`
    /// - Parameter dataFetcher: Optionally provide a custom data fetcher; defaults to live network query.
    init(dataFetcher: DogFactsDataFetcher = DogFactsDataFetcherNetwork()) {
        self.dataFetcher = dataFetcher
    }
    
    /**
     The model coming back from the API.
     
     For example: `{"facts":["The earliest dog fossil dates back to nearly 10,000 B.C."],"success":true}`
     */
    private struct DogFacts: Decodable {
        let facts: [String]
    }
    
    // MARK: DogFactsService

    func fetchDogFact() async throws -> String {
        let data = try await self.dataFetcher.fetch()
        let dogFacts = try JSONDecoder().decode(DogFacts.self, from: data)
        return dogFacts.facts.first ?? "???"
    }    

}
