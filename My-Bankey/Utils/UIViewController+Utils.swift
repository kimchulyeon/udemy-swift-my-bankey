import UIKit

extension UIViewController {
	func setStatusBar() {
//		let navBarAppearance = UINavigationBarAppearance()
//		navBarAppearance.configureWithTransparentBackground()
//		navBarAppearance.backgroundColor = appColor
//		UINavigationBar.appearance().standardAppearance = navBarAppearance
//		UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
		let statusBarSize = UIApplication.shared.statusBarFrame.size
		let frame = CGRect(origin: .zero, size: statusBarSize)
		let statusbarView = UIView(frame: frame)
		
		statusbarView.backgroundColor = appColor
		view.addSubview(statusbarView)
	}
	
	func setTabBarImage(imageName: String, title: String) {
		let configuration = UIImage.SymbolConfiguration(scale: .large)
		let image = UIImage(systemName: imageName, withConfiguration: configuration)
		tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
	}
}
