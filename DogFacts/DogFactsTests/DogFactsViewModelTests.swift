//
//  DogFactsViewModelTests.swift
//  DogFactsTests
//
//  Created by Patrick McGonigle on 5/14/22.
//

import XCTest
@testable import DogFactsSwiftUI

class DogFactsViewModelTests: XCTestCase {

    let mockService = DogFactsServiceMocked()
    var viewModel: DogFactsViewModel?

    override func setUp() async throws {
        self.viewModel = DogFactsViewModel(service: self.mockService)
    }

    func testInitial() {
        switch self.viewModel?.state {
        case .idle: print("Idle, as expcted")
        default: XCTFail("Unexpected state: \(String(describing: viewModel?.state))")
        }
    }

    func testFetchSuccess() async {
        
        self.mockService.mockedFact = "Dogs are cool!"
        
        switch self.viewModel?.state {
        case .idle: print("Idle, as expcted")
        default: XCTFail("Unexpected state: \(String(describing: viewModel?.state))")
        }
        
        await self.viewModel?.fetch()
        switch self.viewModel?.state {
        case .loaded(let dogFact): XCTAssertEqual(dogFact, "Dogs are cool!")
        default: XCTFail("Unexpected state: \(String(describing: viewModel?.state))")
        }
    }

    func testFetchError() async {
        
        mockService.mockedError = DogFactsError.noResponse
        
        switch viewModel?.state {
        case .idle: print("Idle, as expcted")
        default: XCTFail("Unexpected state: \(String(describing: viewModel?.state))")
        }
        
        await viewModel?.fetch()
        switch viewModel?.state {
        case .failed(let error): XCTAssertEqual(error.self as? DogFactsError, DogFactsError.noResponse.self)
        default: XCTFail("Expected an error")
        }
    }

    func testCombine() async {        
        // TODO patmcg... set up a way to test the COmbine binding
    }
    
}
