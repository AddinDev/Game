//
//  File.swift
//  
//
//  Created by addin on 01/04/21.
//

import SIECore
import Combine

public struct GetFavouriteGameRepository<
  GameLocaleDataSource: LocaleDataSource,
  Transformer: Mapper>: Repository
where
  GameLocaleDataSource.Response == FavGameEntity,
  Transformer.Entity == [FavGameEntity],
  Transformer.Domain == [GameModel] {
  
  public typealias Request = Any
  public typealias Response = [GameModel]
  
  private let _localeDataSource: GameLocaleDataSource
  private let _mapper: Transformer
  
  public init(localeDataSource: GameLocaleDataSource,
              mapper: Transformer) {
    self._localeDataSource = localeDataSource
    self._mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<[GameModel], Error> {
    return _localeDataSource.list(request: nil)
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
