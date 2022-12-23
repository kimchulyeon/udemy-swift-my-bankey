import UIKit

class LoginViewController: UIViewController {

	private let loginView = LoginView()
	private let loginButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.configuration = .filled()
		btn.configuration?.imagePadding = 8
		btn.setTitle("Sign In", for: .normal)
		btn.addTarget(self, action: #selector(onClickSigninButton), for: .touchUpInside)
		return btn
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		style()
		layout()
	}
	
	//MARK: - Selectors
	@objc func onClickSigninButton() {
		print("hello")
	}
}


extension LoginViewController {
	private func style() {
		view.translatesAutoresizingMaskIntoConstraints = false
	}
	private func layout() {
		view.addSubview(loginView)
		NSLayoutConstraint.activate([
			loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
		])
		
		view.addSubview(loginButton)
		NSLayoutConstraint.activate([
			loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loginButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 20),
			loginButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginButton.trailingAnchor, multiplier: 1)
		])
	}
}
