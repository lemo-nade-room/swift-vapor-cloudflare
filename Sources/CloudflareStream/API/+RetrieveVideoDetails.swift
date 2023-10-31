import CloudflareLibrary
import Vapor

extension CloudflareStreamClient {

  /// Retrieve Video Details
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/stream-videos-retrieve-video-details
  /// }
  public func retrieveVideoDetails(identifier: String) async throws -> RetrieveVideoDetails {
    let response = try await client.get(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/stream/\(identifier)"
    ) { req in
      req.headers.bearerAuthorization = .init(token: apiToken)
      req.headers.contentType = .json
    }
    return try response.content.decode(RetrieveVideoDetails.self, using: jsonDecoder)
  }
}

public struct RetrieveVideoDetails: Hashable, Content, Sendable, CloudflareStreamResponseContent {
  public var errors: [ResponseError]
  public var messages: [ResponseMessage]?
  public var result: Result?
  public var success: Bool

  public struct Result: Hashable, Content, Sendable {
    public var allowedOrigins: [String]?
    public var created: Date?
    public var creator: String?
    public var duration: Double?
    public var input: Input?
    public var liveInput: String?
    public var maxDurationSeconds: Int?
    public var meta: [String: String]?
    public var modified: Date?
    public var playback: Playback?
    public var preview: String?
    public var readyToStream: Bool?
    public var readyToStreamAt: Date?
    public var requireSignedURLs: Bool?
    public var scheduledDeletion: Date?
    public var size: Double?
    public var status: Status?
    public var thumbnail: String?
    public var thumbnailTimestampPct: Double?
    public var uid: String?
    public var uploadExpiry: Date?
    public var uploaded: Date?
    public var watermark: Watermark?

    public init(
      allowedOrigins: [String]? = nil, created: Date? = nil, creator: String? = nil,
      duration: Double? = nil, input: Input? = nil, liveInput: String? = nil,
      maxDurationSeconds: Int? = nil, meta: [String: String]? = nil, modified: Date? = nil,
      playback: Playback? = nil, preview: String? = nil, readyToStream: Bool? = nil,
      readyToStreamAt: Date? = nil, requireSignedURLs: Bool? = nil, scheduledDeletion: Date? = nil,
      size: Double? = nil, status: Status? = nil, thumbnail: String? = nil,
      thumbnailTimestampPct: Double? = nil, uid: String? = nil, uploadExpiry: Date? = nil,
      uploaded: Date? = nil, watermark: Watermark
    ) {
      self.allowedOrigins = allowedOrigins
      self.created = created
      self.creator = creator
      self.duration = duration
      self.input = input
      self.liveInput = liveInput
      self.maxDurationSeconds = maxDurationSeconds
      self.meta = meta
      self.modified = modified
      self.playback = playback
      self.preview = preview
      self.readyToStream = readyToStream
      self.readyToStreamAt = readyToStreamAt
      self.requireSignedURLs = requireSignedURLs
      self.scheduledDeletion = scheduledDeletion
      self.size = size
      self.status = status
      self.thumbnail = thumbnail
      self.thumbnailTimestampPct = thumbnailTimestampPct
      self.uid = uid
      self.uploadExpiry = uploadExpiry
      self.uploaded = uploaded
      self.watermark = watermark
    }

    public struct Input: Hashable, Content, Sendable {
      public var height: Int
      public var width: Int

      public init(height: Int, width: Int) {
        self.height = height
        self.width = width
      }
    }

    public struct Playback: Hashable, Content, Sendable {
      public var dash: String?
      public var hls: String?

      public init(dash: String? = nil, hls: String? = nil) {
        self.dash = dash
        self.hls = hls
      }
    }

    public struct Status: Hashable, Content, Sendable {
      public var errorReasonCode: String?
      public var errorReasonText: String?
      public var pctComplete: String?
      public var state: State?

      public init(
        errorReasonCode: String? = nil, errorReasonText: String? = nil, pctComplete: String? = nil,
        state: State? = nil
      ) {
        self.errorReasonCode = errorReasonCode
        self.errorReasonText = errorReasonText
        self.pctComplete = pctComplete
        self.state = state
      }

      public enum State: String, Hashable, Content, Sendable {
        case pendingupload, downloading, queued, inprogress, ready, error
      }
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
        created: Date? = nil, downloadedFrom: String? = nil, height: Int? = nil,
        name: String? = nil, opacity: Double? = nil, padding: Double? = nil,
        position: String? = nil, scale: Double? = nil, size: Double? = nil, uid: String? = nil,
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
