//
//  DogFactsComponsable.swift
//  DogFacts
//
//  Created by Patrick McGonigle on 7/12/22.
//

import ComposableArchitecture
import SwiftUI

struct DogFactsState: Equatable {
    var docFact: String?
    var isLoading: Bool = false
}

enum DogFactsAction: Equatable {
    case fetch
    case fetchResponse(Result<String, DogFactsError>)
}

struct DogFactsEnvironment {
    var service: DogFactsService
}

let refreshableReducer = Reducer<
    DogFactsState,
    DogFactsAction,
    DogFactsEnvironment
> { state, action, environment in
    // TODO implement state -> actions -> effect
    return .none
}
