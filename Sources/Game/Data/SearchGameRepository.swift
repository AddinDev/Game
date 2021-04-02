//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import SIECore
import Combine

public struct SearchGameRepository<
  SearchRemoteDataSource: RemoteDataSource,
  Transformer: Mapper>: Repository
where
  SearchRemoteDataSource.Request == String,
  SearchRemoteDataSource.Response == [GameResponse],
  Transformer.Response == [GameResponse],
  Transformer.Domain == [GameModel] {

  public typealias Request = String
  public typealias Response = [GameModel]
  
  private let _remoteDataSource: SearchRemoteDataSource
  private let _mapper: Transformer
  
  public init(remoteDataSource: SearchRemoteDataSource, mapper: Transformer) {
    self._remoteDataSource = remoteDataSource
    self._mapper = mapper
  }
  
  public func execute(request: String?) -> AnyPublisher<[GameModel], Error> {
    guard let request = request else { fatalError("request cant be empty")}
    return _remoteDataSource.execute(request: request)
      .map { _mapper.transformResponseToDomain(response: $0) }
      .eraseToAnyPublisher()
  }
  
}
