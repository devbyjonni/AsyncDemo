//
//  TodosListView.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import SwiftUI

struct TodosListView: View {
    @EnvironmentObject var todoViewModel: TodosViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todoViewModel.todos) { todo in
                    if let url = URL(string: todo.thumbnailUrl) {
                        TodoImageView(url: url, viewModel: TodoImageViewModel())
                            .frame(width: 100, height: 100)
                    } else {
                        Text("Invalid URL")
                    }
                }
            }
            .listStyle(.plain)
            .padding()
            .task {
                await todoViewModel.loadData()
            }
            .navigationTitle("Todos")
        }
    }
}

struct TodosListView_Previews: PreviewProvider {
    static var previews: some View {
        TodosListView()
    }
}
