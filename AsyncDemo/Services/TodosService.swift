//
//  TodosService.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import Foundation

enum ServiceError: Error {
    case invalidResponse
    case invalidData(String)
    case decodingError(String)
    case invalidURL
}

protocol TodosServiceProtocol {
    func fetchJson(from url: URL?) async throws -> [Todo]
}

class TodosService: TodosServiceProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchJson(from url: URL?) async throws -> [Todo] {
        guard let url = url else { throw ServiceError.invalidURL }
        do {
            let (data, response) = try await urlSession.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw ServiceError.invalidResponse
            }
            return try JSONDecoder().decode([Todo].self, from: data)
        } catch {
            throw ServiceError.decodingError("Failed to decode JSON data")
        }
    }
}
