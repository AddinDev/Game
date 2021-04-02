//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import SIECore
import Combine

public struct GetGameRepository<
  GameLocaleDataSource: LocaleDataSource,
  GameRemoteDataSource: RemoteDataSource,
  Transformer: Mapper>: Repository
where
  GameLocaleDataSource.Response == GameEntity,
  GameRemoteDataSource.Response == [GameResponse],
  Transformer.Response == [GameResponse],
  Transformer.Entity == [GameEntity],
  Transformer.Domain == [GameModel] {
  
  public typealias Request = Any
  public typealias Response = [GameModel]
  
  private let _localeDataSource: GameLocaleDataSource
  private let _remoteDataSource: GameRemoteDataSource
  private let _mapper: Transformer
  
  public init(localeDataSource: GameLocaleDataSource,
              remoteDataSource: GameRemoteDataSource,
              mapper: Transformer) {
    self._localeDataSource = localeDataSource
    self._remoteDataSource = remoteDataSource
    self._mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<[GameModel], Error> {
    return _localeDataSource.list(request: nil)
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        if result.isEmpty {
          return _remoteDataSource.execute(request: nil)
            .map { _mapper.transformResponseToEntity(request: nil, response: $0) }
            .catch { _ in _localeDataSource.list(request: nil)}
            .flatMap { _localeDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.list(request: nil)
              .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return _localeDataSource.list(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  
}
