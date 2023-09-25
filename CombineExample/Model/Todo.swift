//
//  Todo.swift
//  CombineExample
//
//  Created by 박혜성(Hyesung Park) on 2023/09/25.
//
import Foundation

struct Todo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

typealias Todos = [Todo]
