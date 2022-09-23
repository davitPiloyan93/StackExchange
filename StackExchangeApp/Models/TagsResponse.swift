//
//  TagsResponse.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import Foundation

struct TagsResponse: Codable {
    let items: [Tag]
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
struct Tag: Codable, Identifiable, Hashable {
    let id = UUID()
    let hasSynonyms, isModeratorOnly, isRequired: Bool
    let count: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case hasSynonyms = "has_synonyms"
        case isModeratorOnly = "is_moderator_only"
        case isRequired = "is_required"
        case count, name
    }
}
