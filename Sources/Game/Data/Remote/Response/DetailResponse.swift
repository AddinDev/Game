//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import Foundation

public struct DetailResponse: Decodable {
  
  let desc: String?
  let released: String?
  let rating: Double?
  
  enum CodingKeys: String, CodingKey {
    
    case desc = "description_raw"
    case released = "released"
    case rating = "rating"
    
  }
  
}
