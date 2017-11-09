import Foundation
public struct ServiceSasParametersType : ServiceSasParametersTypeProtocol {
    public var canonicalizedResource: String?
    public var signedResource: SignedResourceEnum?
    public var signedPermission: PermissionsEnum?
    public var signedIp: String?
    public var signedProtocol: HttpProtocolEnum?
    public var signedStart: Date?
    public var signedExpiry: Date?
    public var signedIdentifier: String?
    public var startPk: String?
    public var endPk: String?
    public var startRk: String?
    public var endRk: String?
    public var keyToSign: String?
    public var rscc: String?
    public var rscd: String?
    public var rsce: String?
    public var rscl: String?
    public var rsct: String?

    enum CodingKeys: String, CodingKey {
        case canonicalizedResource = "canonicalizedResource"
        case signedResource = "signedResource"
        case signedPermission = "signedPermission"
        case signedIp = "signedIp"
        case signedProtocol = "signedProtocol"
        case signedStart = "signedStart"
        case signedExpiry = "signedExpiry"
        case signedIdentifier = "signedIdentifier"
        case startPk = "startPk"
        case endPk = "endPk"
        case startRk = "startRk"
        case endRk = "endRk"
        case keyToSign = "keyToSign"
        case rscc = "rscc"
        case rscd = "rscd"
        case rsce = "rsce"
        case rscl = "rscl"
        case rsct = "rsct"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    canonicalizedResource = try container.decode(String?.self, forKey: .canonicalizedResource)
    signedResource = try container.decode(SignedResourceEnum?.self, forKey: .signedResource)
    signedPermission = try container.decode(PermissionsEnum?.self, forKey: .signedPermission)
    signedIp = try container.decode(String?.self, forKey: .signedIp)
    signedProtocol = try container.decode(HttpProtocolEnum?.self, forKey: .signedProtocol)
    signedStart = try container.decode(Date?.self, forKey: .signedStart)
    signedExpiry = try container.decode(Date?.self, forKey: .signedExpiry)
    signedIdentifier = try container.decode(String?.self, forKey: .signedIdentifier)
    startPk = try container.decode(String?.self, forKey: .startPk)
    endPk = try container.decode(String?.self, forKey: .endPk)
    startRk = try container.decode(String?.self, forKey: .startRk)
    endRk = try container.decode(String?.self, forKey: .endRk)
    keyToSign = try container.decode(String?.self, forKey: .keyToSign)
    rscc = try container.decode(String?.self, forKey: .rscc)
    rscd = try container.decode(String?.self, forKey: .rscd)
    rsce = try container.decode(String?.self, forKey: .rsce)
    rscl = try container.decode(String?.self, forKey: .rscl)
    rsct = try container.decode(String?.self, forKey: .rsct)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(canonicalizedResource, forKey: .canonicalizedResource)
    try container.encode(signedResource as! SignedResourceEnum?, forKey: .signedResource)
    try container.encode(signedPermission as! PermissionsEnum?, forKey: .signedPermission)
    try container.encode(signedIp, forKey: .signedIp)
    try container.encode(signedProtocol as! HttpProtocolEnum?, forKey: .signedProtocol)
    try container.encode(signedStart, forKey: .signedStart)
    try container.encode(signedExpiry, forKey: .signedExpiry)
    try container.encode(signedIdentifier, forKey: .signedIdentifier)
    try container.encode(startPk, forKey: .startPk)
    try container.encode(endPk, forKey: .endPk)
    try container.encode(startRk, forKey: .startRk)
    try container.encode(endRk, forKey: .endRk)
    try container.encode(keyToSign, forKey: .keyToSign)
    try container.encode(rscc, forKey: .rscc)
    try container.encode(rscd, forKey: .rscd)
    try container.encode(rsce, forKey: .rsce)
    try container.encode(rscl, forKey: .rscl)
    try container.encode(rsct, forKey: .rsct)
  }
}
