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
  
  func fetchPosts() {
    ApiService.fetchPosts()
      .sink { completion in
        switch completion {
        case .failure(let err) :
          print("PostVM - fetchPosts: err: \(err)")
        case .finished:
          print("PostVM - fetchPosts: finished")
        }
      }  receiveValue: { (posts: Posts) in
        print("PostVM - fetchPosts / posts: \(posts.count)")
      }.store(in: &subscriptions)
  }
}
