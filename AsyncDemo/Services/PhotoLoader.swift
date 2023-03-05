//
//  PhotoLoader.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import UIKit


protocol PhotoLoaderProtocol {
    func fetchImage(from url: URL?) async throws -> UIImage?
}

class PhotoLoader: PhotoLoaderProtocol {
    private static let cache = NSCache<NSString, UIImage>()
    private var task: URLSessionDataTask?

    enum ImageLoaderError: Error {
        case invalidURL
        case invalidResponse
        case corruptData
        case cacheError
    }
    
    func fetchImage(from url: URL?) async throws -> UIImage? {
        guard let url = url else { throw ImageLoaderError.invalidURL }
        
        // Check cache
        let cacheKey = url.absoluteString
        if let cachedImage = Self.cache.object(forKey: cacheKey as NSString) {
            return cachedImage
        }
        
        // Cancel any in-flight requests
        task?.cancel()
        
        // Fetch image
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ImageLoaderError.invalidResponse
        }
        guard let image = UIImage(data: data) else {
            throw ImageLoaderError.corruptData
        }
        
        // Cache image
        Self.cache.setObject(image, forKey: cacheKey as NSString)
        
        return image
    }
    
    func cancelFetch() {
        task?.cancel()
    }
}
