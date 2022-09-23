//
//  StackExchangeService.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import Foundation

protocol StackExchangeServiceProtocol {
    func fetchTagsResponse(currentPage: Int) async throws -> TagsResponse
    func fetchQuestionsResponse(tagName: String) async throws -> QuestionsResponse
}

final class StackExchangeService: StackExchangeServiceProtocol {
    private let stackExchangeNetworkService: StackExchangeNetworkServiceProtocol
    
    init(networkService: StackExchangeNetworkServiceProtocol) {
        self.stackExchangeNetworkService = networkService
    }
    
    func fetchTagsResponse(currentPage: Int) async throws -> TagsResponse {
        return try await stackExchangeNetworkService.fetchTagsResponse(currentPage: currentPage)
    }
    
    func fetchQuestionsResponse(tagName: String) async throws -> QuestionsResponse {
        return try await stackExchangeNetworkService.fetchQuestionsResponse(tagName: tagName)
    }
}
