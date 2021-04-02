//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import SIECore
import Combine

public struct GetDetailRepository<
  DetailRemoteDataSource: RemoteDataSource,
  Transformer: Mapper>: Repository
where
  DetailRemoteDataSource.Request == String,
  DetailRemoteDataSource.Response == DetailResponse,
  Transformer.Response == DetailResponse,
  Transformer.Domain == DetailModel {
  
  public typealias Request = String
  public typealias Response = DetailModel
  
  private let _remoteDataSource: DetailRemoteDataSource
  private let _mapper: Transformer
  
  public init(remoteDataSource: DetailRemoteDataSource, mapper: Transformer) {
    self._remoteDataSource = remoteDataSource
    self._mapper = mapper
  }
  
  public func execute(request: String?) -> AnyPublisher<DetailModel, Error> {
    guard let request = request else { fatalError("request cant be empty")}
    return _remoteDataSource.execute(request: request)
      .map { _mapper.transformResponseToDomain(response: $0) }
      .eraseToAnyPublisher()
  }
  
}
