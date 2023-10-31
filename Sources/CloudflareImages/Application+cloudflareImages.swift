import Vapor

extension Vapor.Application {

  public struct CloudflareImagesClientKey: StorageKey {
    public typealias Value = CloudflareImagesClient
  }

  /// Cloudflare Images Client
  public var cloudflareImages: CloudflareImagesClient {
    get {
      guard let cloudflareImages = storage[CloudflareImagesClientKey.self] else {
        fatalError("Cloudflare Images Client is not configured. Use app.cloudflareImages = ...")
      }
      return cloudflareImages
    }
    set {
      storage[CloudflareImagesClientKey.self] = newValue
    }
  }
}

extension Request {
  public var cloudflareImages: CloudflareImagesClient { application.cloudflareImages }
}
