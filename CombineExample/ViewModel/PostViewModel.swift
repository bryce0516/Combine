//
//  PostViewModel.swift
//  CombineExample
//
//  Created by 박혜성(Hyesung Park) on 2023/09/25.
//

import Foundation
import Combine

class PostVM: ObservableObject {
  var subscriptions = Set<AnyCancellable>()
  
  func fetchTodos() {
    ApiService.fetchPosts()
  }
}
