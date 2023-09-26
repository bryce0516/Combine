//
//  ApiService.swift
//  CombineExample
//
//  Created by 박혜성(Hyesung Park) on 2023/09/25.
//

import Foundation
import Combine

enum API {
  case fetchTodos
  case fetchPosts
  
  var url : URL {
    switch self {
      case .fetchTodos: return URL(string: "https://jsonplaceholder.typicode.com/todos")!
      case .fetchPosts: return URL(string: "https://jsonplaceholder.typicode.com/posts")!
    }
  }
}


enum ApiService {
  static func fetchTodos() -> AnyPublisher<Todos, Error> {
    return URLSession.shared.dataTaskPublisher(for: API.fetchTodos.url)
      .map{ $0.data }
      .decode(type: Todos.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
  
  static func fetchPosts(_ todosCount: Int = 0) -> AnyPublisher<Posts, Error> {
    print("received todos count, \(todosCount)")
    return URLSession.shared.dataTaskPublisher(for: API.fetchPosts.url)
      .map { $0.data }
      .decode(type: Posts.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
  
  static func fetchTodosAndPostsAtTheSameTime() -> AnyPublisher<(Todos, Posts), Error> {
    let todos = fetchTodos()
    let posts = fetchPosts()
    
    return Publishers
      .CombineLatest(todos, posts)
      .eraseToAnyPublisher()
  }
  
  static func fetchTodosAndThenPosts() -> AnyPublisher<[Post], Error> {
    return fetchTodos().flatMap { (todos: Todos) in
      return fetchPosts(todos.count).eraseToAnyPublisher()
    }.eraseToAnyPublisher()
  }
}
