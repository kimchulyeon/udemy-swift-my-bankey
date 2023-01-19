import Foundation

public class LocalState {
	private enum Keys: String {
		case hasOnboared
	}
	
	public static var hasOnboared: Bool {
		get {
			return UserDefaults.standard.bool(forKey: Keys.hasOnboared.rawValue)
		}
		set(newValue) {
			UserDefaults.standard.set(newValue, forKey: Keys.hasOnboared.rawValue)
			
			UserDefaults.standard.synchronize()
		}
	}
}

