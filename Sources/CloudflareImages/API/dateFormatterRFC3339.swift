import Foundation

private func prepareDateFormatterRFC3339() -> DateFormatter {
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
  formatter.timeZone = TimeZone(secondsFromGMT: 0)
  return formatter
}

let dateFormatterRFC3339 = prepareDateFormatterRFC3339()
