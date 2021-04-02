//
//  File.swift
//  
//
//  Created by addin on 01/04/21.
//

import Foundation
import SIECore

public struct AddFavGameTransformer: Mapper {
  
  public typealias Request = Any
  public typealias Response = Any
  public typealias Entity = FavGameEntity
  public typealias Domain = GameModel
  
  public init() { }
  
  public func transformResponseToEntity(request: Any?, response: Any) -> FavGameEntity {
    fatalError()
  }
  
  public func transformEntityToDomain(entity: FavGameEntity) -> GameModel {
    fatalError()
  }
  
  public func transformResponseToDomain(response: Any) -> GameModel {
    fatalError()
  }
  
  public func transformDomainToEntity(entity: GameModel) -> FavGameEntity {
    let newFavGame = FavGameEntity()
    newFavGame.id = entity.id
    newFavGame.title = entity.title
    newFavGame.image = entity.image
    newFavGame.rating = entity.rating
    return newFavGame
  }
  
}
