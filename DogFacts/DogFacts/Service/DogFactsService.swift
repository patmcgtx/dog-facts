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
    
}
