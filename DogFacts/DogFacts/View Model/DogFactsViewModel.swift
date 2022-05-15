//
//  DogFactsViewModel.swift
//  DogFacts
//
//  Created by Patrick McGonigle on 5/14/22.
//

import Combine

/// View model for the dog facts view
class DogFactsViewModel {
    
    /// The state the dog facts view can take on.
    enum State {
        case idle
        case loading
        case loaded(dogFact: String)
        case failed(error: Error)
    }
    
    /// The current state for the dog facts view; Combine-observable.
    @Published private(set) var state: State = .idle
    
    private let service: DogFactsService
    
    init(service: DogFactsService) {
        self.service = service
    }
    
    /// Triggers a fetch of a new dog fact and updates the state
    func fetch() async {
        
        self.state = .loading
        
        do {
            let dogFact = try await self.service.fetchDogFact()
            self.state = .loaded(dogFact: dogFact)
        } catch {
            self.state = .failed(error: error)
        }
    }
    
}
