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
	private let errorMessage: UILabel = {
		let msg = UILabel()
		msg.translatesAutoresizingMaskIntoConstraints = false
		msg.textAlignment = .center
		msg.textColor = .systemRed
		msg.numberOfLines = 0
		msg.isHidden = true
		msg.text = "Wrong username or password!"
		return msg
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		style()
		layout()
	}
	
	//MARK: - Selectors
	@objc func onClickSigninButton() {
		print("hello")
		errorMessage.isHidden = false
	}
}


extension LoginViewController {
	private func style() {
		view.translatesAutoresizingMaskIntoConstraints = false
	}
	private func layout() {
		// input field
		view.addSubview(loginView)
		NSLayoutConstraint.activate([
			loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
		])
		
		// login button
		view.addSubview(loginButton)
		NSLayoutConstraint.activate([
			loginButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
			loginButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
			loginButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 20),
			loginButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginButton.trailingAnchor, multiplier: 1)
		])
		
		view.addSubview(errorMessage)
		NSLayoutConstraint.activate([
			errorMessage.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
			errorMessage.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor)
		])
	}
}
