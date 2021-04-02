//
//  File.swift
//  
//
//  Created by addin on 01/04/21.
//

import SIECore

public struct FavGameTransformer: Mapper {
  
  public typealias Request = Any
  public typealias Response = Any
  public typealias Entity = [FavGameEntity]
  public typealias Domain = [GameModel]
  
  public init() { }
  
  public func transformEntityToDomain(entity: [FavGameEntity]) -> [GameModel] {
    return entity.map { game in
      return GameModel(id: game.id,
                       title: game.title,
                       image: game.image,
                       rating: game.rating)
    }
  }
  
  public func transformResponseToEntity(request: Any?, response: Any) -> [FavGameEntity] {
    fatalError()
  }
  
  public func transformResponseToDomain(response: Any) -> [GameModel] {
    fatalError()
  }
  
  public func transformDomainToEntity(entity: [GameModel]) -> [FavGameEntity] {
    return entity.map { game in
      let newFavGame = FavGameEntity()
      newFavGame.id = game.id
      newFavGame.title = game.title
      newFavGame.image = game.image
      newFavGame.rating = game.rating
      return newFavGame
    }
  }
  
}
