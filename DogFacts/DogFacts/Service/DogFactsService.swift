//
//  DogFactsService.swift
//  DocFactsMac
//
//  Created by Patrick McGonigle on 5/4/22.
//

import Foundation

/// Protocol for fetching dog facts
protocol DogFactsService {
    
    /**
     Fetches a new dog fact.
     - Returns: A dog fact as a string
     */
    func fetch() async throws -> String
}


/// Fetches dog facts and converts to a model.
struct LiveDogFactsService: DogFactsService {
    
    private var dataFetcher: DogFactsDataFetcher
    
    /**
     The model coming back from the API.
     
     For example: `{"facts":["The earliest dog fossil dates back to nearly 10,000 B.C."],"success":true}`
     */
    private struct DogFacts: Decodable {
        let facts: [String]
    }

    /**
     Creates a DogFactsService.
     - Parameter dataFetcher: The service to inject to fetch the raw dog fact data
     */
    init(dataFetcher: DogFactsDataFetcher) {
        
        self.dataFetcher = dataFetcher
        
        // Note I'm putting the URL here because this is where I decode the data from that URL.
        self.dataFetcher.urlPath = "https://dog-api.kinduff.com/api/facts"
    }
    
    // MARK: DogFactsService

    func fetch() async throws -> String {
        let data = try await self.dataFetcher.fetch()
        let dogFacts = try JSONDecoder().decode(DogFacts.self, from: data)
        return dogFacts.facts.first ?? "???"
    }    

}
