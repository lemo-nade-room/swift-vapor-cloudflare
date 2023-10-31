import CloudflareLibrary
import Vapor

extension CloudflareImagesClient {

  /// List Images V2
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/cloudflare-images-list-images-v2
  /// }
  public func listImagesV2(perPage: Int? = nil, sortOrder: CloudflareLibrary.SortOrder? = nil)
    async throws -> ListImagesV2
  {
    let response = try await client.get(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/images/v2"
    ) { req in
      try req.query.encode([
        "per_page": perPage.map(String.init),
        "sort_order": sortOrder.map(\.rawValue),
      ])
      req.headers.bearerAuthorization = .init(token: apiToken)
      req.headers.contentType = .json
    }
    return try response.content.decode(ListImagesV2.self, using: jsonDecoder)
  }
}

public struct ListImagesV2: Hashable, Content, CloudflareImagesResponseContent {
  public var errors: [ResponseError]
  public var messages: [ResponseMessage]?
  public var result: Result?
  public var success: Bool

  public init(
    errors: [ResponseError],
    messages: [ResponseMessage]? = nil,
    result: Result? = nil,
    success: Bool
  ) {
    self.errors = errors
    self.messages = messages
    self.result = result
    self.success = success
  }

  public struct Result: Hashable, Content {
    public var continuation_token: String?
    public var images: [Image]

    public init(continuation_token: String? = nil, images: [Image]) {
      self.continuation_token = continuation_token
      self.images = images
    }

    public struct Image: Hashable, Content {
      public var filename: String?
      public var id: String?
      public var meta: [String: String]?
      public var requireSignedURLs: Bool?
      public var uploaded: Date?
      public var variants: [String]?

      public init(
        filename: String? = nil,
        id: String? = nil,
        meta: [String: String]? = nil,
        requireSignedURLs: Bool? = nil,
        uploaded: Date? = nil,
        variants: [String]? = nil
      ) {
        self.filename = filename
        self.id = id
        self.meta = meta
        self.requireSignedURLs = requireSignedURLs
        self.uploaded = uploaded
        self.variants = variants
      }
    }
  }
}
