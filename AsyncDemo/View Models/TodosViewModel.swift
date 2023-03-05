//
//  TodosViewModel.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import UIKit

@MainActor
class TodosViewModel: ObservableObject {
    private let todosService: TodosServiceProtocol
    @Published var todos = [Todo]()
    
    init(todosService: TodosServiceProtocol = TodosService()) {
        self.todosService = todosService
    }
    
    func loadData() async {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        do {
            todos = try await todosService.fetchJson(from: url)
        } catch let error {
            print("Error loading todos: \(error.localizedDescription)")
        }
    }
}
