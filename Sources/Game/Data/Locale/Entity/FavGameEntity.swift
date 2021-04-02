//
//  File.swift
//  
//
//  Created by addin on 01/04/21.
//

import Foundation
import RealmSwift

public class FavGameEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var rating: String = ""
  @objc dynamic var favorite = false

  public override class func primaryKey() -> String? {
    return "id"
  }
  
}
