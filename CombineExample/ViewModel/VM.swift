//
//  VM.swift
//  CombineExample
//
//  Created by 박혜성(Hyesung Park) on 2023/09/26.
//

import Foundation
import Combine

class VM: ObservableObject {
  var subscriptions = Set<AnyCancellable>()
  
  func fetchTodosAndPostsAtTheSameTime () {
    ApiService.fetchTodosAndPostsAtTheSameTime()
      .sink { completion in
        switch completion {
        case .failure(let err):
          print("VM - fetchTodosAndPostsAtTheSameTime: err: \(err)")
        case .finished:
          print("VM - fetchTodosAndPostsAtTheSameTime: finished")
        }
      } receiveValue: { (todos: Todos, posts:Posts) in
        print("VM - fetchTodosAndPostsAtTheSameTime / posts.count: \(posts.count) / todos.count: \(todos.count)")
      }.store(in: &subscriptions)
  }
  
  func fetchTodosAndThenPosts () {
    ApiService.fetchTodosAndThenPosts()
      .sink { completion in
        switch completion {
        case .failure(let err):
          print("VM - fetchTodosAndThenPosts: err: \(err)")
        case .finished:
          print("VM - fetchTodosAndThenPosts: finished")
        }
      } receiveValue: { (posts:Posts) in
        print("VM - fetchTodosAndThenPosts / posts.count: \(posts.count)")
      }.store(in: &subscriptions)

  }
}
