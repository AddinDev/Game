//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import Foundation
import RealmSwift

public class GameEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var rating: String = ""
  
  public override class func primaryKey() -> String? {
    return "id"
  }
  
}
