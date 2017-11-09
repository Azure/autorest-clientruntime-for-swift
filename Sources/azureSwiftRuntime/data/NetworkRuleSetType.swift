import Foundation
public struct NetworkRuleSetType : NetworkRuleSetTypeProtocol {
    public var bypass: BypassEnum?
    public var virtualNetworkRules: [VirtualNetworkRuleTypeProtocol?]?
    public var ipRules: [IPRuleTypeProtocol?]?
    public var defaultAction: DefaultActionEnum?

    enum CodingKeys: String, CodingKey {
        case bypass = "bypass"
        case virtualNetworkRules = "virtualNetworkRules"
        case ipRules = "ipRules"
        case defaultAction = "defaultAction"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bypass = try container.decode(BypassEnum?.self, forKey: .bypass)
    virtualNetworkRules = try container.decode([VirtualNetworkRuleType?]?.self, forKey: .virtualNetworkRules)
    ipRules = try container.decode([IPRuleType?]?.self, forKey: .ipRules)
    defaultAction = try container.decode(DefaultActionEnum?.self, forKey: .defaultAction)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(bypass as! BypassEnum?, forKey: .bypass)
    try container.encode(virtualNetworkRules as! [VirtualNetworkRuleType?]?, forKey: .virtualNetworkRules)
    try container.encode(ipRules as! [IPRuleType?]?, forKey: .ipRules)
    try container.encode(defaultAction as! DefaultActionEnum?, forKey: .defaultAction)
  }
}
