//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import Foundation
import Alamofire
import SIECore
import Combine

public struct GetDetailRemoteDataSource: RemoteDataSource {

  public typealias Request = String
  public typealias Response = DetailResponse
  
  private let _endpoint: String
  
  public init(endpoint: String) {
    _endpoint = endpoint
  }
  
  public func execute(request: String?) -> AnyPublisher<DetailResponse, Error> {
    return Future<DetailResponse, Error> { completion in
      
      guard let request = request else { return completion(.failure(URLError.invalidRequest)) }

      if let url = URL(string: _endpoint + "/\(request)" + Api.key) {
      AF.request(url)
        .validate()
        .responseDecodable(of: DetailResponse.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
          case .failure:
            completion(.failure(DatabaseError.requestFailed))
          }
        }
    }
    }.eraseToAnyPublisher()
  }
  
}
