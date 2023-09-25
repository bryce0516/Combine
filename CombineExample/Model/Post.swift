//
//  Post.swift
//  CombineExample
//
//  Created by 박혜성(Hyesung Park) on 2023/09/25.
//

import Foundation

struct Post: Codable {
  let userID, id: Int
  let title, body: String
  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case id, title, body
  }
}


typealias Posts = [Post]

