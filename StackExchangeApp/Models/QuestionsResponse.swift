//
//  QuestionsResponse.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import Foundation


// MARK: - Welcome
struct QuestionsResponse: Codable {
    let items: [Question]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

// MARK: - Item
struct Question: Codable, Identifiable, Hashable {
    let id = UUID()
    let tags: [String]
    let isAnswered: Bool
    let viewCount, answerCount, score, lastActivityDate: Int
    let creationDate, questionID: Int
    let link: String
    let title: String
    let lastEditDate, acceptedAnswerID, closedDate: Int?
    let closedReason: String?

    enum CodingKeys: String, CodingKey {
        case tags
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case questionID = "question_id"
        case link, title
        case lastEditDate = "last_edit_date"
        case acceptedAnswerID = "accepted_answer_id"
        case closedDate = "closed_date"
        case closedReason = "closed_reason"
    }
}


