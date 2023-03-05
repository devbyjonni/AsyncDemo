//
//  PhotosListView.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import SwiftUI

struct PhotosListView: View {
    @EnvironmentObject var viewModel: PhotosListViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.photos) { photo in
                    if let url = URL(string: photo.thumbnailUrl) {
                        PhotoView(url: url, viewModel: PhotoViewModel())
                            .frame(width: 100, height: 100)
                    } else {
                        Text("Invalid URL")
                    }
                }
            }
            .listStyle(.plain)
            .padding()
            .task {
                await viewModel.loadData()
            }
            .navigationTitle("Photos")
        }
    }
}

struct PhotosListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosListView()
    }
}
