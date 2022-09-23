//
//  StackExchangeAppTests.swift
//  StackExchangeAppTests
//
//  Created by Davit Piloyan on 23.09.22.
//

import XCTest
@testable import StackExchangeApp

final class StackExchangeServiceMock: StackExchangeServiceProtocol {
    
    var tagsResponse: TagsResponse?
    
    var errorCase = false
    
    func fetchTagsResponse(currentPage: Int) async throws -> TagsResponse {
        guard !errorCase else {
            throw AppError.invalidUrl
        }
        
        return tagsResponse!
    }
}

final class StackExchangeAppTests: XCTestCase {
    
    var service: StackExchangeServiceMock!
    var viewModel: TagsViewModel!
    
    override func setUp() async throws {
        service = StackExchangeServiceMock()
        viewModel = TagsViewModel(stackExchangeService: service)
    }
    

    func test_InitialFetch() async {
        let tag = Tag(hasSynonyms: false, isModeratorOnly: true, isRequired: false, count: 1, name: "Swift")
        service.tagsResponse = TagsResponse(items: [tag], hasMore: true, quotaMax: 0, quotaRemaining: 0)
        await viewModel.initialFetch()
        
        XCTAssertEqual(viewModel.tags.first!.name, "Swift")
        XCTAssertTrue(viewModel.hasMoreItems())
        
        
        service.tagsResponse = TagsResponse(items: [tag], hasMore: false, quotaMax: 0, quotaRemaining: 0)
        await viewModel.initialFetch()
        XCTAssertFalse(viewModel.hasMoreItems())
        
    }
    
    func test_InitialFetch_ErrorCase() async {
        service.errorCase = true
        
        await viewModel.initialFetch()
        
        XCTAssertNotNil(viewModel.error)
    }

}
