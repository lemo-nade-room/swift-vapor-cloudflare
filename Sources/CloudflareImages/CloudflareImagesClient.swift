import Vapor

public final class CloudflareImagesClient {

  /// Vapor's HTTP Client
  public let client: any Vapor.Client

  /// Cloudflare Images Account Identifier
  public let accountIdentifier: String

  /// Cloudflare Images API Token
  public let apiToken: String

  public init(client: Vapor.Client, accountIdentifier: String, apiToken: String) {
    self.client = client
    self.accountIdentifier = accountIdentifier
    self.apiToken = apiToken
  }

  var bearer: BearerAuthorization {
    .init(token: apiToken)
  }
}
