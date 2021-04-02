//
//  File.swift
//  
//
//  Created by addin on 02/04/21.
//

import Foundation
import Combine
import SIECore

public struct RemoveFavouriteGameRepository<
  GameLocaleDataSource: LocaleDataSource,
  Transformer: Mapper>: Repository
where
  GameLocaleDataSource.Request == FavGameEntity,
  GameLocaleDataSource.Response == Bool,
  Transformer.Domain == GameModel,
  Transformer.Entity == FavGameEntity {
  
  public typealias Request = GameModel
  public typealias Response = Bool
  
  private let _localeDataSource: GameLocaleDataSource
  private let _mapper: Transformer
  
  public init(
    localeDataSource: GameLocaleDataSource,
    mapper: Transformer) {
    _localeDataSource = localeDataSource
    _mapper = mapper
  }
  
  public func execute(request: GameModel?) -> AnyPublisher<Bool, Error> {
    guard let request = request else { fatalError("request cant be empty") }
    return _localeDataSource.remove(entity: _mapper.transformDomainToEntity(entity: request))
      .eraseToAnyPublisher()
  }
  
}
