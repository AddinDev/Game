//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import Foundation
import SIECore
import Combine
import Alamofire

public struct GetGameRemoteDataSource: RemoteDataSource {
  
  public typealias Request = Any
  public typealias Response = [GameResponse]
  
  private let _endpoint: String
  
  public init(endpoint: String) {
    _endpoint = endpoint
  }
  
  public func execute(request: Any?) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      if let url = URL(string: _endpoint) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameResponses.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.games))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
}
