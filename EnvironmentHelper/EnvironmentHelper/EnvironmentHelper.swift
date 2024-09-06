import Foundation

public final class EnvironmentHelper {
    public static let shared = EnvironmentHelper()
    
    private init() { }
    
    public func fetch(for key: EnvironmentKey) -> String? {
        retrieve(for: key.rawValue)
    }
}

private extension EnvironmentHelper {
    func retrieve(for key: String) -> String? {
        guard let secrets = Bundle.main.infoDictionary else { return nil }
        
        return secrets[key] as? String
    }
}
