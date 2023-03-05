//
//  Photo.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import Foundation

struct Photo: Identifiable, Codable {
    let id: Int
    let title: String
    let thumbnailUrl: String
}
