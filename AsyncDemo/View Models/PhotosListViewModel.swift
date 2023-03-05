//
//  PhotosListViewModel.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import UIKit

@MainActor
class PhotosListViewModel: ObservableObject {
    private let service: ServiceProtocol
    @Published var photos = [Photo]()
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func loadData() async {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        do {
            photos = try await service.fetchJson(from: url)
        } catch let error {
            print("Error loading photos: \(error.localizedDescription)")
        }
    }
}
