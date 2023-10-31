import Vapor

public enum SortOrder: String, CaseIterable, Hashable, Sendable, Content {
  case asc, desc
}
