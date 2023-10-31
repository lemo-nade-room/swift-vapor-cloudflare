import Foundation
import Vapor

private func prepareJSONDecoder() -> JSONDecoder {
  let jsonDecoder = JSONDecoder()
  jsonDecoder.dateDecodingStrategy = .custom { decoder throws -> Date in
    let string = try decoder.singleValueContainer().decode(String.self)

    // ISO8601
    if let date = ISO8601DateFormatter().date(from: string) {
      return date
    }

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    if let date = formatter.date(from: string) {
      return date
    }

    throw Abort(
      .badRequest,
      reason:
        "Data corrupted at path '\(decoder.codingPath[0].stringValue)'. Expected date string to be ISO8601"
    )
  }
  return jsonDecoder
}

public let jsonDecoder = prepareJSONDecoder()
