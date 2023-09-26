//
//  UserVM.swift
//  CombineExample
//
//  Created by 박혜성(Hyesung Park) on 2023/09/26.
//

import Foundation
import Combine

class UserVM: ObservableObject {
  var subscriptions = Set<AnyCancellable>()
  
  func fetchUsers() {
    ApiService.fetchUsers()
      .sink { completion in
        switch completion {
        case .failure(let err) :
          print("UserVM - fetchUsers: err: \(err)")
        case .finished:
          print("UserVM - fetchUsers: finished")
        }
      }  receiveValue: { (users: Users) in
        print("UserVM - fetchUsers / users: \(users.count)")
      }.store(in: &subscriptions)
  }
}

