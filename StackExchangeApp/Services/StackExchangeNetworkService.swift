//
//  StackExchangeNetworkService.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import Foundation

protocol StackExchangeNetworkServiceProtocol {
    func fetchTagsResponse(currentPage: Int) async throws -> TagsResponse
}

final class StackExchangeNetworkService: StackExchangeNetworkServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    private let baseUrl = "https://api.stackexchange.com/"
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTagsResponse(currentPage: Int) async throws -> TagsResponse {
        let endPoint = createGetTagsResponseEndPoint(currentPage: currentPage)
        return try await networkService.sendRequest(endPoint: endPoint)
    }
    
    private func createGetTagsResponseEndPoint(currentPage: Int) -> EndPoint {
        let path = "/2.3/tags?page\(currentPage)&pagesize=40&order=desc&sort=popular&site=stackoverflow"
        return EndPoint(baseUrl: baseUrl, path: path)
    }
}
