import Foundation
import Vapor

public func createJSONString<T: Codable>(_ content: T) throws -> String {
  let jsonData = try JSONSerialization.data(withJSONObject: content, options: [])
  guard let jsonString = String(data: jsonData, encoding: .utf8) else {
    throw JSONTextCreateError()
  }
  return jsonString
}

public struct JSONTextCreateError: Error {
  public init() {}
}
