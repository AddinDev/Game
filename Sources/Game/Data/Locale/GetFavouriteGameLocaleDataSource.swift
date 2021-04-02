//
//  File.swift
//  
//
//  Created by addin on 01/04/21.
//

import Foundation
import Combine
import RealmSwift
import SIECore

public struct GetFavouriteGameLocaleDataSource: LocaleDataSource {

  public typealias Request = Any
  public typealias Response = FavGameEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Any?) -> AnyPublisher<[FavGameEntity], Error> {
    return Future<[FavGameEntity], Error> { completion in
      let games: Results<FavGameEntity> = {
        _realm.objects(FavGameEntity.self)
          .sorted(byKeyPath: "title", ascending: true)
      }()
      completion(.success(games.toArray(ofType: FavGameEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: [FavGameEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func addOne(entity: Any) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func remove(entity: Any) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
}
