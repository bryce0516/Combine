//
//  ContentView.swift
//  CombineExample
//
//  Created by 박혜성(Hyesung Park) on 2023/09/25.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject var postViewModel = PostVM()
  @StateObject var todoViewModel = TodoVM()
  @StateObject var viewModel = VM()
  
  init() {
    self._postViewModel = StateObject.init(wrappedValue: PostVM())
    self._todoViewModel = StateObject.init(wrappedValue: TodoVM())
    self._viewModel =
    StateObject.init(wrappedValue: VM())
  }
  
  var body: some View {
    VStack {
      Button {
        self.postViewModel.fetchPosts()
      } label: {
        Text("call posts")
          .foregroundColor(.white)
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 10).fill(Color.gray)
      )
      
      Button {
        self.todoViewModel.fetchTodos()
      } label: {
        Text("call todos")
          .foregroundColor(.white)
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 10).fill(Color.gray)
      )
      
      Button {
        self.viewModel.fetchTodosAndPostsAtTheSameTime()
      } label: {
        Text("call todos posts")
          .foregroundColor(.white)
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 10).fill(Color.gray)
      )
      
      Button {
        self.viewModel.fetchTodosAndThenPosts()
      } label: {
        Text("call todos then posts")
          .foregroundColor(.white)
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 10).fill(Color.gray)
      )
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
