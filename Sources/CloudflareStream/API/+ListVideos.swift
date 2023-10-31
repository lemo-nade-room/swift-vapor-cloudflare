import CloudflareLibrary
import Vapor

extension CloudflareStreamClient {

  /// List Videos
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/stream-videos-list-videos
  /// }
  public func listVideos(
    asc: Bool? = nil, creator: String? = nil, end: Date? = nil, includeCounts: Bool? = nil,
    search: String? = nil, start: Date? = nil, status: ListVideosStatus? = nil,
    type: ListVideosType? = nil
  ) async throws -> ListVideos {
    let response = try await client.get(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/stream"
    ) { req in
      req.headers.bearerAuthorization = .init(token: apiToken)
      req.headers.contentType = .json
      try req.query.encode([
        "asc": asc.map(String.init),
        "creator": creator,
        "end": end.map({ $0.ISO8601Format() }),
        "include_counts": includeCounts.map(String.init),
        "search": search,
        "start": start.map({ $0.ISO8601Format() }),
        "status": status.map(\.rawValue),
        "type": type.map(\.rawValue),
      ])
    }
    return try response.content.decode(ListVideos.self, using: jsonDecoder)
  }
}

public enum ListVideosStatus: String, Hashable, Content, CaseIterable {
  case pendingupload, downloading, queued, inprogress, ready, error
}

public enum ListVideosType: String, Hashable, Content, CaseIterable {
  case vod, live
}

public struct ListVideos: Hashable, Content {
  public var errors: [ResponseError]?
  public var messages: [ResponseMessage]?
  public var result: [Result]?
  public var success: Bool
  public var range: Int?
  public var total: Int?

  public init(
    errors: [ResponseError], messages: [ResponseMessage], result: [Result]? = nil, success: Bool,
    range: Int? = nil, total: Int? = nil
  ) {
    self.errors = errors
    self.messages = messages
    self.result = result
    self.success = success
    self.range = range
    self.total = total
  }

  public struct Result: Hashable, Content {
    public var allowedOrigins: [String]?
    public var created: Date?
    public var creator: String?
    public var duration: Double?
    public var input: Input?
    public var continuation_token: String?
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

    public init(
      allowedOrigins: [String]? = nil, created: Date? = nil, creator: String? = nil,
      duration: Double? = nil, input: Input? = nil, continuation_token: String? = nil,
      liveInput: String? = nil, maxDurationSeconds: Int? = nil, meta: [String: String]? = nil,
      modified: Date? = nil, playback: Playback? = nil, preview: String? = nil,
      readyToStream: Bool? = nil, readyToStreamAt: Date? = nil, requireSignedURLs: Bool? = nil,
      scheduledDeletion: Date? = nil, size: Double? = nil, status: Status? = nil,
      thumbnail: String? = nil, thumbnailTimestampPct: Double? = nil, uid: String? = nil,
      uploadExpiry: Date? = nil, uploaded: Date? = nil
    ) {
      self.allowedOrigins = allowedOrigins
      self.created = created
      self.creator = creator
      self.duration = duration
      self.input = input
      self.continuation_token = continuation_token
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
    }

    public struct Input: Hashable, Content {
      public var height: Int
      public var width: Int

      public init(height: Int, width: Int) {
        self.height = height
        self.width = width
      }
    }

    public struct Playback: Hashable, Content {
      public var dash: String?
      public var hls: String?

      public init(dash: String? = nil, hls: String? = nil) {
        self.dash = dash
        self.hls = hls
      }
    }

    public struct Status: Hashable, Content {
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

      public enum State: String, Hashable, Content {
        case pendingupload, downloading, queued, inprogress, ready, error
      }
    }

    public struct Watermark: Hashable, Content {
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
