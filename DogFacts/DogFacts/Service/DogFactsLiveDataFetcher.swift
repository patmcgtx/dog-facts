//
//  DogFactsLiveDataFetcher.swift
//  DocFactsMac
//
//  Created by Patrick McGonigle on 5/4/22.
//

import Foundation

/// Fetches dog facts raw data from a live network endpoint
struct DogFactsLiveDataFetcher: DogFactsDataFetcher {
    
    var urlPath: String = ""
        
    private let urlSession = URLSession.shared

    /// Old-school completion block version
    func fetchData(completion: @escaping (Result<Data, Error>) -> ()) {
        if let url = URL(string: self.urlPath) {
            let dataTask = self.urlSession.dataTask(with: url) { maybeData, maybeResponse, maybeError in
                if let error = maybeError {
                    completion(.failure(error))
                } else if let data = maybeData {
                    completion(.success(data))
                }
            }
            dataTask.resume()
        } else {
            completion(.failure(Errors.badURL))
        }
    }
        
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
