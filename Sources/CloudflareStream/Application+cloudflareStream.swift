import Vapor

extension Vapor.Application {

  public struct CloudflareStreamClientKey: StorageKey {
    public typealias Value = CloudflareStreamClient
  }

  /// Cloudflare Stream Client
  public var cloudflareStream: CloudflareStream {
    get {
      guard let cloudflareStream = storage[CloudflareStreamClientKey.self] else {
        fatalError("Cloudflare Stream Client is not configured. Use app.cloudflareStream = ...")
      }
      return cloudflareStream
    }
    set {
      storage[CloudflareStreamClientKey.self] = newValue
    }
  }
}

extension Request {
  public var cloudflareStream: CloudflareStreamClient { application.cloudflareStream }
}
