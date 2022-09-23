//
//  QuestionsViewModel.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import Foundation

protocol QuestionsViewModelProtocol: ObservableObject {
    
    var questions: [Question] { get set }
    var error: AppError? { get set }
    
    func initialFetch() async
//    func loadMore() async
//    func hasMoreItems() -> Bool
}

final class QuestionsViewModel: QuestionsViewModelProtocol {
    
    @Published var questions: [Question] = []
    @Published var error: AppError?
    
    private let service: StackExchangeServiceProtocol
    private var currentPage = 1
    private var lastResponse: QuestionsResponse?
    private let tagName: String
    
    init(stackExchangeService: StackExchangeServiceProtocol,
         tagName: String) {
        self.service = stackExchangeService
        self.tagName = tagName
    }
    
    @MainActor
    func initialFetch() async {
        invalidError()
        let nextPage = 1
        do {
            try await fetchQuestionsResponse(tagName: tagName)
            currentPage = nextPage
            questions = lastResponse?.items ?? []
        } catch (let err) {
            error = err as? AppError
        }
        
        print(questions)
    }
    
    func invalidError() {
        if error != nil {
            error = nil
        }
    }
    
    private func fetchQuestionsResponse(tagName: String) async throws {
        lastResponse = try await service.fetchQuestionsResponse(tagName: tagName)
    }
    
}
