//
//  ContentView.swift
//  CombineExample
//
//  Created by 박혜성(Hyesung Park) on 2023/09/25.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject var postViewModel = PostVM()
  
  init() {
    self._postViewModel = StateObject.init(wrappedValue: PostVM())
  }
  var body: some View {
    VStack {
      Button {
        self.postViewModel.fetchPosts()
      } label: {
        Text("call todos")
          .foregroundColor(.black)
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
