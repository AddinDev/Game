//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import Foundation
import SIECore
import Combine
import RealmSwift

public struct GetGameLocaleDataSource: LocaleDataSource {
  
  public typealias Request = Any
  public typealias Response = GameEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Any?) -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      let games: Results<GameEntity> = {
        _realm.objects(GameEntity.self)
          .sorted(byKeyPath: "title", ascending: true)
      }()
      completion(.success(games.toArray(ofType: GameEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for game in entities {
            _realm.add(game)
          }
        }
        completion(.success(true))
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  public func addOne(entity: Any) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func remove(entity: Any) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
}
