//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import Foundation

public struct GameResponses: Decodable {
  
  let games: [GameResponse]
  
  private enum CodingKeys: String, CodingKey {
    case games = "results"
  }
  
}

public struct GameResponse: Decodable {
  
  let id: Int?
  let title: String?
  let image: String?
  let rating: Double?
  
  private enum CodingKeys: String, CodingKey {
    
    case id = "id"
    case title = "name"
    case image = "background_image"
    case rating = "rating"
    
  }
  
}
