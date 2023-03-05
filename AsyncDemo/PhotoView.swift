//
//  PhotoView.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import SwiftUI

struct PhotoView<ViewModel: PhotoViewModelProtocol>: View {
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
        PhotoView(url: URL(string: "")!, viewModel: PhotoViewModel())
    }
}
