//
//  TodoImageViewModel.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import UIKit

protocol TodoImageViewModelProtocol: ObservableObject {
    var uiImage: UIImage? { get }
    var isLoading: Bool { get }
    func loadImage(from url: URL) async
}


class TodoImageViewModel: TodoImageViewModelProtocol {
    private let imageLoader: ImageLoaderProtocol
    @Published var uiImage: UIImage?
    
    var isLoading: Bool {
        uiImage == nil
    }
    
    init(imageLoader: ImageLoaderProtocol = ImageLoader()) {
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

class MockTodoImageViewModel: TodoImageViewModelProtocol {
    var uiImage: UIImage? = nil
    var isLoading: Bool = false
    
    func loadImage(from url: URL) async {
        // Do nothing
    }
}
