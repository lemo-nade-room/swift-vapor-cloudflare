import CloudflareLibrary
import Vapor

extension CloudflareStreamClient {

  /// Storage use
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/stream-videos-storage-usage
  /// }
  public func storageUse(creator: String? = nil) async throws -> StorageUse {
    let response = try await client.get(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/stream/storage-usage"
    ) { req in
      req.headers.bearerAuthorization = .init(token: apiToken)
      req.headers.contentType = .json
      try req.query.encode(["creator": creator])
    }
    return try response.content.decode(StorageUse.self, using: jsonDecoder)
  }
}

public struct StorageUse: Hashable, Content, CloudflareStreamResponseContent {
  public var errors: [ResponseError]
  public var messages: [ResponseMessage]?
  public var result: Result?
  public var success: Bool

  public struct Result: Hashable, Content {
    public var creator: String?
    public var totalStorageMinutes: Double?
    public var totalStorageMinutesLimit: Int?
    public var videoCount: Int?

    public init(
      creator: String? = nil, totalStorageMinutes: Double? = nil,
      totalStorageMinutesLimit: Int? = nil, videoCount: Int? = nil
    ) {
      self.creator = creator
      self.totalStorageMinutes = totalStorageMinutes
      self.totalStorageMinutesLimit = totalStorageMinutesLimit
      self.videoCount = videoCount
    }
  }

  public init(
    errors: [ResponseError], messages: [ResponseMessage]? = nil, result: Result? = nil,
    success: Bool
  ) {
    self.errors = errors
    self.messages = messages
    self.result = result
    self.success = success
  }
}
