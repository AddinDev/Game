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

public struct AddFavouriteGameLocaleDataSource: LocaleDataSource {
  
  public typealias Request = FavGameEntity
  public typealias Response = Bool
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: FavGameEntity?) -> AnyPublisher<[Bool], Error> {
    fatalError()
  }
  
  public func add(entities: [Bool]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func addOne(entity: FavGameEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          _realm.add(entity, update: .modified)
        }
        completion(.success(true))
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  public func remove(entity: FavGameEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let game = { _realm.objects(FavGameEntity.self)
        .filter("id = '\(entity.id)'")
      }().first {
        do {
          try _realm.write {
            _realm.delete(game)
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}
