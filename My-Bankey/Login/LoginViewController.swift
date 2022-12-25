import UIKit

class LoginViewController: UIViewController {

	//MARK: - Properties
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Bankey"
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 30)
		return label
	}()
	private let loginView = LoginView()
	private lazy var loginButton: UIButton = {
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
		msg.text = "Wrong username | password!"
		msg.textColor = .systemRed
		msg.numberOfLines = 0
		msg.textAlignment = .center
		msg.isHidden = true
		return msg
	}()
	var username: String? { return loginView.usernameTextField.text }
	var password: String? { return loginView.passwordTextField.text }


	//MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()

		style()
		layout()
	}

	//MARK: - Selectors
	@objc func onClickSigninButton() {
		guard let username = username, let password = password else {
			assertionFailure("Username / Password should never be nil")
			return
		}
		if username.isEmpty || password.isEmpty {
			errorMessage.isHidden = false
			errorMessage.text = "Username / Password cannot be empty"
			return
		} else {
			errorMessage.isHidden = true
			errorMessage.text = ""
			if username == "test@test.com" && password == "123456" {
				loginButton.configuration?.showsActivityIndicator = true
			} else {
				errorMessage.isHidden = false
				errorMessage.text = "Wrong Username / Password"
			}
		}
	}
}


extension LoginViewController {
	private func style() {
		view.translatesAutoresizingMaskIntoConstraints = false
	}
	private func layout() {
		// title label
		view.addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60)
		])
		
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
			loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loginButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 20),
			loginButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginButton.trailingAnchor, multiplier: 1)
		])
		// error message
		view.addSubview(errorMessage)
		NSLayoutConstraint.activate([
			errorMessage.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
			errorMessage.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2)
		])
	}
}
