//
//  DogFactsViewModelTests.swift
//  DogFactsTests
//
//  Created by Patrick McGonigle on 5/14/22.
//

import XCTest
@testable import DogFacts

class DogFactsViewModelTests: XCTestCase {

    func testInitial() {
        let service = DogFactsServiceMock()
        let viewModel = DogFactsViewModel(service: service)
        switch viewModel.state {
        case .idle: print("Idle, as expcted")
        default: XCTFail("Unexpected state: \(viewModel.state)")
        }
    }

    func testFetchSuccess() async {
        
        let service = DogFactsServiceMock()
        service.resultingFact = "Dogs are cool!"
        let viewModel = DogFactsViewModel(service: service)
        
        switch viewModel.state {
        case .idle: print("Idle, as expcted")
        default: XCTFail("Unexpected state: \(viewModel.state)")
        }
        
        await viewModel.fetch()
        switch viewModel.state {
        case .loaded(let dogFact): XCTAssertEqual(dogFact, "Dogs are cool!")
        default: XCTFail("Unexpected state: \(viewModel.state)")
        }
    }

    func testFetchError() async {
        
        let service = DogFactsServiceMock()
        service.resultingError = Errors.noResponse
        let viewModel = DogFactsViewModel(service: service)
        
        switch viewModel.state {
        case .idle: print("Idle, as expcted")
        default: XCTFail("Unexpected state: \(viewModel.state)")
        }
        
        await viewModel.fetch()
        switch viewModel.state {
        case .failed(let error): XCTAssertEqual(error.self as? Errors, Errors.noResponse.self)
        default: XCTFail("Expected an error")
        }
    }

    func testCombine() async {
        
        let service = DogFactsServiceMock()
        service.resultingFact = "Dogs are way cool!"
        let viewModel = DogFactsViewModel(service: service)
        
        // TODO patmcg...
//        let subscription = viewModel.$state.receive(on: DispatchQueue.main)
//            .sink { state in
//                switch state {
//                case .idle: print("Idle, as expected")
//                default: XCTFail("Unexpected state: \(viewModel.state)")
//                }
//            }
    }
    
}
