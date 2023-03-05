//
//  TodoImageView.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import SwiftUI

struct TodoImageView<ViewModel: TodoImageViewModelProtocol>: View {
    var url: URL
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            if let image = viewModel.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Text("❌ loading image")
            }
        }
        .task {
            await viewModel.loadImage(from: url)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        TodoImageView(url: URL(string: "")!, viewModel: TodoImageViewModel())
    }
}
