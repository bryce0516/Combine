import Foundation
import Combine
import Alamofire
enum API {
  case fetchTodos
  case fetchPosts
  case fetchUsers
  
  var url: URL {
    switch self {
    case .fetchTodos: return URLs.todos
    case .fetchPosts: return URLs.posts
    case .fetchUsers: return URLs.users
    }
  }
  
  struct URLs {
    static let todos = URL(string: "https://jsonplaceholder.typicode.com/todos")!
    static let posts = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    static let users = URL(string: "https://jsonplaceholder.typicode.com/users")!
  }
}

enum PostsOrUsers {
  case posts(Posts)
  case users(Users)
}

enum ApiService {
  
  private static func fetchData<T: Decodable>(for api: API) -> AnyPublisher<T, Error> {
    AF.request(api.url)
      .publishDecodable(type: T.self)
      .value()
      .mapError { (error : AFError) in
        return error as Error
      }
      .eraseToAnyPublisher()
//    return URLSession.shared.dataTaskPublisher(for: api.url)
//      .map(\.data)
//      .decode(type: T.self, decoder: JSONDecoder())
//      .eraseToAnyPublisher()
  }
  
  static func fetchTodos() -> AnyPublisher<Todos, Error> {
    return fetchData(for: .fetchTodos)
  }
  
  static func fetchPosts(_ todosCount: Int = 0) -> AnyPublisher<Posts, Error> {
    print("received todos count, \(todosCount)")
    return fetchData(for: .fetchPosts)
  }
  
  static func fetchUsers() -> AnyPublisher<Users, Error> {
    return fetchData(for: .fetchUsers)
  }
  
  static func fetchTodosAndPostsAtTheSameTime() -> AnyPublisher<(Todos, Posts), Error> {
    return Publishers.CombineLatest(fetchTodos(), fetchPosts())
      .eraseToAnyPublisher()
  }
  
  static func fetchTodosAndThenPosts() -> AnyPublisher<Posts, Error> {
    return fetchTodos()
      .flatMap { todos in
        fetchPosts(todos.count)
      }
    
      .eraseToAnyPublisher()
  }
  
  static func fetchTodosAndThenPostsWithFilter() -> AnyPublisher<Posts, Error> {
    return fetchTodos()
      .filter { $0.count > 99 }
      .flatMap { todos in
        fetchPosts(todos.count)
      }
    
      .eraseToAnyPublisher()
  }
  
  static func fetchTodosAndThenOthers() -> AnyPublisher<PostsOrUsers, Error> {
    return fetchTodos()
      .flatMap { todos -> AnyPublisher<PostsOrUsers, Error> in
        if todos.count < 200 {
          return fetchPosts().map(PostsOrUsers.posts).eraseToAnyPublisher()
        } else {
          return fetchUsers().map(PostsOrUsers.users).eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
}
