//
//  NetworkService.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import Foundation

struct EndPoint {
    let baseUrl: String
    let path: String
    var method = "GET"
}

protocol NetworkServiceProtocol {
    func sendRequest<T: Decodable>(endPoint: EndPoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    
    func sendRequest<T: Decodable>(endPoint: EndPoint) async throws -> T {
        guard let requestUrl = URL(string:endPoint.baseUrl + endPoint.path) else {
            throw AppError.invalidUrl
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = endPoint.method
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode else {
                throw AppError.noResponse
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw AppError.unknown(error.localizedDescription)
        }
    }
}
