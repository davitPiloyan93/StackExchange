//
//  AppError.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import Foundation

protocol CustomError: Error {
    var message: String { get }
    var title: String { get }
}

enum AppError: CustomError, Identifiable {
    var id: UUID { UUID() }
    
    case invalidUrl
    case noResponse
    case unknown(String)
    
    var message: String {
        switch self {
        case .invalidUrl:
            return "Something wrong happened, please connect your admin."
        case .noResponse:
            return "You haven't items"
        case .unknown(let message):
            return message
        }
    }
    
    var title: String {
        "Attention"
    }
}
