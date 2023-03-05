//
//  Todo.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import Foundation

struct Todo: Identifiable, Codable {
    let id: Int
    let title: String
    let thumbnailUrl: String
}
