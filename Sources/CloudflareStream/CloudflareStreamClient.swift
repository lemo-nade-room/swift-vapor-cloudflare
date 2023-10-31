import Vapor

public final class CloudflareStreamClient {

  /// Vapor's HTTP Client
  public let client: any Vapor.Client

  /// Cloudflare Stream Account Identifier
  public let accountIdentifier: String

  /// Cloudflare Stream API Token
  public let apiToken: String

  public init(client: Vapor.Client, accountIdentifier: String, apiToken: String) {
    self.client = client
    self.accountIdentifier = accountIdentifier
    self.apiToken = apiToken
  }
}
