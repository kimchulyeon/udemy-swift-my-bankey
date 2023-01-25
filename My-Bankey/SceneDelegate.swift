//
//  SceneDelegate.swift
//  My-Bankey
//
//  Created by chulyeon kim on 2022/12/23.
//

import UIKit

let appColor: UIColor = .systemTeal

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	let loginViewController = LoginViewController()
	let onboardingContainerViewController = OnboardingContainerViewController()
	let mainViewController = MainViewController()

	// var hasOnboared: Bool = false UserDefaults로 대체

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = scene as? UIWindowScene else { return }
		window = UIWindow(windowScene: scene)
		window?.makeKeyAndVisible()
		window?.backgroundColor = .systemBackground

		loginViewController.delegate = self
		onboardingContainerViewController.delegate = self
		
		mainViewController.setStatusBar()

		UINavigationBar.appearance().isTranslucent = false
		UINavigationBar.appearance().backgroundColor = appColor
		
		registerNotification()
		
		window?.rootViewController = loginViewController
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}
}

//MARK: - delegate ============================================
extension SceneDelegate: LoginViewControllerDelegate {
	func didLogin(_ sender: LoginViewController) {
		LocalState.hasOnboared ? setRootViewController(mainViewController) : setRootViewController(onboardingContainerViewController)
	}
}
extension SceneDelegate: OnboardingContainerViewControllerDelegate {
	func didFinishOnboarding(_ sender: OnboardingContainerViewController) {
		LocalState.hasOnboared = true
		setRootViewController(mainViewController)
	}
}

extension SceneDelegate: LogoutDelegate {
	func didLogout() {
		setRootViewController(loginViewController)
	}
}


extension SceneDelegate {
	//MARK: - func ============================================
	private func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
		guard animated, let window = self.window else { return }

		window.rootViewController = vc
		window.makeKeyAndVisible()
		UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
	}
	
	private func registerNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name("Logout"), object: nil)
	}
	
	
	//MARK: - selector ============================================
	@objc func logout() {
		setRootViewController(loginViewController)
	}
}
