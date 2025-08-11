//
//  PawsTests.swift
//  PawsTests
//
//  Created by Rodrigo Peña on 3/8/25.
//

import Testing
import Foundation
import SwiftUI
@testable import Paws

// MARK: - MockDogService

final class MockDogService: DogService {
    var mockBreeds: [String] = []
    var mockImages: [URL] = []
    var shouldFail = false

    func fetchBreeds() async throws -> [String] {
        if shouldFail { throw NetworkError.invalidResponse }
        return mockBreeds
    }

    func fetchImages(for breed: String, count: Int) async throws -> [URL] {
        if shouldFail { throw NetworkError.invalidResponse }
        return Array(mockImages.prefix(count))
    }
}

// MARK: - DogServiceTests

struct DogServiceTests {
    
    private let mockService = MockDogService()
    
    // MARK: - BreedListViewModel Tests
    
    @Test
    func testBreedListLoadSuccess() async throws {

        mockService.mockBreeds = ["akita", "beagle"]
        
        let viewModel = await BreedListViewModelImpl(service: mockService)
        
        await viewModel.load()
        
        try await Task.sleep(nanoseconds: 300_000_000)
        
        #expect(viewModel.breeds == ["akita", "beagle"])
        #expect(viewModel.isLoading == false)
    }
    
    @Test
    func testBreedListLoadFailure() async throws {

        mockService.shouldFail = true
        
        let viewModel = await BreedListViewModelImpl(service: mockService)
        await viewModel.load()
        
        try await Task.sleep(nanoseconds: 300_000_000)
        
        #expect(viewModel.breeds.isEmpty)
        #expect(viewModel.isLoading == false)
    }
    
    // MARK: - BreedImagesViewModel Tests
    
    @Test
    func testBreedImagesLoadSuccess() async throws {

        mockService.mockImages = (1...10).map { URL(string: "https://mock.com/dog\($0).jpg")! }
        
        let viewModel = await BreedImagesViewModelImpl(breed: "beagle", service: mockService)
        await viewModel.load()
        
        try await Task.sleep(nanoseconds: 300_000_000)
        
        #expect(viewModel.images.count == 10)
        #expect(viewModel.isLoading == false)
    }
    
    @Test
    func testBreedImagesLoadFailure() async throws {
        
        mockService.shouldFail = true
        
        let viewModel = await BreedImagesViewModelImpl(breed: "husky", service: mockService)
        await viewModel.load()
        
        try await Task.sleep(nanoseconds: 300_000_000)
        
        #expect(viewModel.images.isEmpty)
        #expect(viewModel.isLoading == false)
    }
}
