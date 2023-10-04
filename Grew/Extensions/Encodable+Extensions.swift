//
//  Encodable+Extensions.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import Foundation

extension Encodable {
  public var toDictionary: [String: Any] {
    guard let object = try? JSONEncoder().encode(self) else { return [:] }
    guard let dictionary = try? JSONSerialization.jsonObject(
      with: object,
      options: []
    ) as? [String: Any] else {
      return [:]
    }
    return dictionary
  }
}
