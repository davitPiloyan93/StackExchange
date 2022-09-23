//
//  TagsViewModel.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import Foundation

protocol TagsViewModelProtocol: ObservableObject {
    
    var tags: [Tag] { get set }
    var error: AppError? { get set }
    
    func initialFetch() async
    func loadMore() async
    func hasMoreItems() -> Bool
}

final class TagsViewModel: TagsViewModelProtocol {
    
    @Published var tags: [Tag] = []
    @Published var error: AppError?
    
    private let service: StackExchangeServiceProtocol
    private var currentPage = 1
    private var lastResponse: TagsResponse?
    
    init(stackExchangeService: StackExchangeServiceProtocol) {
        self.service = stackExchangeService
    }
    
    @MainActor
    func initialFetch() async {
        invalidError()
        let nextPage = 1
        do {
            try await fetchTagsResponse(currentPage: nextPage)
            currentPage = nextPage
            tags = lastResponse?.items ?? []
        } catch (let err) {
            error = err as? AppError
        }
    }
    
    func invalidError() {
        if error != nil {
            error = nil
        }
    }
    
    
    @MainActor
    func loadMore() async {
        invalidError()
        let nextPage = currentPage + 1
        do {
            try await fetchTagsResponse(currentPage: nextPage)
            currentPage = nextPage
            tags.append(contentsOf: lastResponse?.items ?? [])
        } catch (let err) {
            error = err as? AppError
        }
    }
    
    private func fetchTagsResponse(currentPage: Int) async throws {
        lastResponse = try await service.fetchTagsResponse(currentPage: currentPage)
    }
    
    func hasMoreItems() -> Bool {
        return lastResponse?.hasMore ?? false
    }
}

