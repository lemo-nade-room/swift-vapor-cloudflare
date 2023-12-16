import CloudflareLibrary
import Vapor

extension CloudflareStreamClient {

  /// Upload videos via direct upload URLs
  ///
  ///  https://developers.cloudflare.com/api/operations/stream-videos-upload-videos-via-direct-upload-ur-ls
  public func uploadVideosViaDirectUploadURLs(
    uploadCreator: String? = nil,
    allowedOrigins: [String]? = nil,
    creator: String? = nil,
    expiry: Date? = nil,
    maxDurationSeconds: Int,
    meta: [String: String]? = nil,
    requireSignedURLs: Bool? = nil,
    scheduledDeletion: Date? = nil,
    thumbnailTimestampPct: Double? = nil,
    watermarkUid: String? = nil
  ) async throws -> UploadVideosViaDirectUploadURLs {
    let response = try await client.post(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/stream/direct_upload"
    ) { req in
      req.headers.bearerAuthorization = bearer
      req.headers.contentType = .json
      if let uploadCreator {
        req.headers.add(name: "Upload-Creator", value: uploadCreator)
      }
      try req.content.encode(
        VideoUploadRequest(
          allowedOrigins: allowedOrigins,
          creator: creator,
          expiry: expiry,
          maxDurationSeconds: maxDurationSeconds,
          meta: meta,
          requireSignedURLs: requireSignedURLs,
          scheduledDeletion: scheduledDeletion,
          thumbnailTimestampPct: thumbnailTimestampPct,
          watermark: watermarkUid.map { .init(uid: $0) }
        ))
    }
    return try response.content.decode(UploadVideosViaDirectUploadURLs.self, using: jsonDecoder)
  }

  /// Upload videos via direct upload URLs. Expiry is a time interval from now.
  ///
  ///  https://developers.cloudflare.com/api/operations/stream-videos-upload-videos-via-direct-upload-ur-ls
  public func uploadVideosViaDirectUploadURLsExpiryByInterval(
    uploadCreator: String? = nil,
    allowedOrigins: [String]? = nil,
    creator: String? = nil,
    expiry: TimeInterval? = nil,
    maxDurationSeconds: Int,
    meta: [String: String]? = nil,
    requireSignedURLs: Bool? = nil,
    scheduledDeletion: Date? = nil,
    thumbnailTimestampPct: Double? = nil,
    watermarkUid: String? = nil
  ) async throws -> UploadVideosViaDirectUploadURLs {
    try await uploadVideosViaDirectUploadURLs(
      uploadCreator: uploadCreator,
      allowedOrigins: allowedOrigins,
      creator: creator,
      expiry: expiry.map { Date(timeIntervalSinceNow: $0) },
      maxDurationSeconds: maxDurationSeconds,
      meta: meta,
      requireSignedURLs: requireSignedURLs,
      scheduledDeletion: scheduledDeletion,
      thumbnailTimestampPct: thumbnailTimestampPct,
      watermarkUid: watermarkUid
    )
  }
}

private struct VideoUploadRequest: Content {
  var allowedOrigins: [String]?
  var creator: String?
  var expiry: Date?
  var maxDurationSeconds: Int
  var meta: String?
  var requireSignedURLs: Bool?
  var scheduledDeletion: Date?
  var thumbnailTimestampPct: Double?
  var watermark: WaterMark?

  init(
    allowedOrigins: [String]? = nil, creator: String? = nil, expiry: Date? = nil,
    maxDurationSeconds: Int, meta: [String: String]? = nil, requireSignedURLs: Bool? = nil,
    scheduledDeletion: Date? = nil, thumbnailTimestampPct: Double? = nil,
    watermark: WaterMark? = nil
  ) throws {
    self.allowedOrigins = allowedOrigins
    self.creator = creator
    self.expiry = expiry
    self.maxDurationSeconds = maxDurationSeconds
    self.meta = try meta.map(createJSONString)
    self.requireSignedURLs = requireSignedURLs
    self.scheduledDeletion = scheduledDeletion
    self.thumbnailTimestampPct = thumbnailTimestampPct
    self.watermark = watermark
  }

  struct WaterMark: Content {
    var uid: String
  }
}

public struct UploadVideosViaDirectUploadURLs: Hashable, Content, Sendable,
  CloudflareStreamResponseContent
{
  public var errors: [ResponseError]
  public var messages: [ResponseMessage]?
  public var result: Result?
  public var success: Bool

  public init(
    errors: [ResponseError], messages: [ResponseMessage]? = nil, result: Result? = nil,
    success: Bool
  ) {
    self.errors = errors
    self.messages = messages
    self.result = result
    self.success = success
  }

  public struct Result: Hashable, Content, Sendable {
    public var scheduledDeletion: Date?
    public var uid: String?
    public var uploadURL: String?
    public var watermark: Watermark?

    public init(
      scheduledDeletion: Date? = nil, uid: String? = nil, uploadURL: String? = nil,
      watermark: Watermark? = nil
    ) {
      self.scheduledDeletion = scheduledDeletion
      self.uid = uid
      self.uploadURL = uploadURL
      self.watermark = watermark
    }

    public struct Watermark: Hashable, Content, Sendable {
      public var created: Date?
      public var downloadedFrom: String?
      public var height: Int?
      public var name: String?
      public var opacity: Double?
      public var padding: Double?
      public var position: String?
      public var scale: Double?
      public var size: Double?
      public var uid: String?
      public var width: Int?

      public init(
        created: Date? = nil,
        downloadedFrom: String? = nil,
        height: Int? = nil,
        name: String? = nil,
        opacity: Double? = nil,
        padding: Double? = nil,
        position: String? = nil,
        scale: Double? = nil,
        size: Double? = nil,
        uid: String? = nil,
        width: Int? = nil
      ) {
        self.created = created
        self.downloadedFrom = downloadedFrom
        self.height = height
        self.name = name
        self.opacity = opacity
        self.padding = padding
        self.position = position
        self.scale = scale
        self.size = size
        self.uid = uid
        self.width = width
      }
    }
  }
}
