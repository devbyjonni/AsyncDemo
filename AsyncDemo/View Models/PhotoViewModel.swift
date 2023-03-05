//
//  PhotoViewModel.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import UIKit

protocol PhotoViewModelProtocol: ObservableObject {
    var uiImage: UIImage? { get }
    var isLoading: Bool { get }
    func loadImage(from url: URL) async
}


class PhotoViewModel: PhotoViewModelProtocol {
    private let imageLoader: PhotoLoaderProtocol
    @Published var uiImage: UIImage?
    
    var isLoading: Bool {
        uiImage == nil
    }
    
    init(imageLoader: PhotoLoaderProtocol = PhotoLoader()) {
        self.imageLoader = imageLoader
    }
    
    @MainActor
    func loadImage(from url: URL) async {
        do {
            uiImage = try await imageLoader.fetchImage(from: url)
        } catch let error {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
}

class MockPhotoViewModel: PhotoViewModelProtocol {
    var uiImage: UIImage? = nil
    var isLoading: Bool = false
    
    func loadImage(from url: URL) async {
        // Do nothing
    }
}
