//
//  TodoVM.swift
//  CombineExample
//
//  Created by 박혜성(Hyesung Park) on 2023/09/26.
//
import Foundation
import Combine

class TodoVM: ObservableObject {
  var subscriptions = Set<AnyCancellable>()
  
  func fetchTodos() {
    ApiService.fetchTodos()
      .sink { completion in
        switch completion {
        case .failure(let err) :
          print("TodoVM - fetchTodos: err: \(err)")
        case .finished:
          print("TodoVM - fetchTodos: finished")
        }
      }  receiveValue: { (todos: Todos ) in
        print("TodoVM - fetchTodos / todos: \(todos.count)")
      }.store(in: &subscriptions)
  }
}
