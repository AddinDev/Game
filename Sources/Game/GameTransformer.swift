//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import SIECore

public struct GameTransformer: Mapper {
  
  public typealias Request = Any
  public typealias Response = [GameResponse]
  public typealias Entity = [GameEntity]
  public typealias Domain = [GameModel]
  
  public init() { }
  
  public func transformResponseToEntity(request: Any?, response: [GameResponse]) -> [GameEntity] {
    return response.map { game in
      let gameEntity = GameEntity()
      gameEntity.id = String(game.id ?? 0)
      gameEntity.title = game.title ?? ""
      gameEntity.image = game.image ?? ""
      gameEntity.rating = String(game.rating ?? 0.0)
      return gameEntity
    }
  }
  
  public func transformEntityToDomain(entity: [GameEntity]) -> [GameModel] {
    return entity.map { game in
      return GameModel(id: game.id,
                       title: game.title,
                       image: game.image,
                       rating: game.rating)
    }
  }
  
  public func transformResponseToDomain(response: [GameResponse]) -> [GameModel] {
    return response.map { game in
      return GameModel(id: String(game.id ?? 0),
                       title: game.title ?? "",
                       image: game.image ?? "",
                       rating: String(game.rating ?? 0.0))
    }
  }
  
  public func transformDomainToEntity(entity: [GameModel]) -> [GameEntity] {
    fatalError()
  }
  
}
