import Foundation
import Vapor

public struct CloudflareImagesError: Error, DebuggableError, AbortError, Hashable, Content {

  public var errors: [ResponseError]
  public var messages: [ResponseMessage]?
  public var status: HTTPStatus { .internalServerError }

  public var reason: String {
    errors.map { $0.message }.joined(separator: ", ")
  }

  public init(
    errors: [ResponseError],
    messages: [ResponseMessage]? = nil
  ) {
    self.errors = errors
    self.messages = messages
  }
}

protocol CloudflareImagesResponseContent: Hashable, Content {
  associatedtype R
  var success: Bool { get }
  var errors: [ResponseError] { get }
  var messages: [ResponseMessage]? { get }
  var result: R? { get }
}

public struct ResponseError: Hashable, Content {
  public var code: Int
  public var message: String
}

public struct ResponseMessage: Hashable, Content {
  public var code: Int
  public var message: String
}

extension CloudflareImagesResponseContent {
  /// Returns the result if the request was successful, otherwise throws an error.
  /// - Throws `CloudflareImagesError`
  var requireResult: R {
    get throws {
      guard success, let result else {
        throw CloudflareImagesError(
          errors: errors,
          messages: messages
        )
      }
      return result
    }
  }
}
