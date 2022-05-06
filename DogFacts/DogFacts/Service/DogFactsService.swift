//
//  DogFactsService.swift
//  DocFactsMac
//
//  Created by Patrick McGonigle on 5/4/22.
//

import Foundation

/// Fetches dog facts and converts to a model
struct DogFactsService {
    
    private var dataFetcher: DogFactsDataFetcher
    
    // The model coming back from the API
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

    /**
     The old-school completion block version.
     - Parameter completion: Closure to execute when the fetch attempt completes, indicating success or failure.
     */
    func fetch(completion: @escaping (Result<String, Error>) -> ()) {
        
        self.dataFetcher.fetchData { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let dogFacts = try JSONDecoder().decode(DogFacts.self, from: data)
                    completion(.success(dogFacts.facts.first ?? "???"))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
        
    // MARK: async/await function version
    
    /**
     The async/await function version. 🤩
     - Returns: A dog fact as a string
     */
    func fetch() async throws -> String {
        let data = try await self.dataFetcher.fetch()
        let dogFacts = try JSONDecoder().decode(DogFacts.self, from: data)
        return dogFacts.facts.first ?? "???"
    }
    
    /**
     The async/await computed property version. 🤩
     - Returns: A dog fact as a string
     */
    var dogFact: String {
        get async throws {
            return try await self.fetch()
        }
    }

    
    // MARK: Combine

    // MARK: TODO Obj-C
}
