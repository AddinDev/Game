//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import SIECore
import Foundation

public struct DetailTransformer: Mapper {

  public typealias Request = Any
  public typealias Response = DetailResponse
  public typealias Entity = Any
  public typealias Domain = DetailModel
  
  public init() {}
  
  public func transformResponseToEntity(request: Any?, response: DetailResponse) -> Any {
    fatalError()
  }
  
  public func transformEntityToDomain(entity: Any) -> DetailModel {
    fatalError()
  }
  
  public func transformResponseToDomain(response: DetailResponse) -> DetailModel {
    return DetailModel(desc: response.desc ?? "",
                       released: formatDate(response.released ?? ""),
                       rating: String(response.rating ?? 0.0))
  }
  
  private func formatDate(_ date: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMM d, yyyy"
    
    if let dateString = dateFormatterGet.date(from: date) {
      return dateFormatterPrint.string(from: dateString)
    }
    
    return ""
  }
  
  public func transformDomainToEntity(entity: DetailModel) -> Any {
    fatalError()
  }
  
}
