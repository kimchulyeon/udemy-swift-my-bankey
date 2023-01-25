import UIKit


//MARK: - protocol ============================================
protocol LoginViewControllerDelegate: AnyObject {
	func didLogin(_ sender: LoginViewController) // LoginViewController 데이터를 전달
}

protocol LogoutDelegate: AnyObject {
	func didLogout()
}

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
		btn.addTarget(self, action: #selector(tappedSigninButton), for: .touchUpInside)
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

	
	weak var delegate: LoginViewControllerDelegate?
	
	// animation
	var titleLabelLeadingAnchor: NSLayoutConstraint?
	var leadingEdgeOnScreen: CGFloat = 16
	var leadingEdgeOffScreen: CGFloat = -1000

	//MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()

		style()
		layout()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		loginView.usernameTextField.text = nil
		loginView.passwordTextField.text = nil
		loginButton.configuration?.showsActivityIndicator = false
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		animate()
	}

	//MARK: - Selectors
	@objc func tappedSigninButton() {
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
			if username == "test" && password == "123" {
				loginButton.configuration?.showsActivityIndicator = true
				//let vc = OnboardingContainerViewController()
				
				delegate?.didLogin(self)
				
				//vc.modalPresentationStyle = .fullScreen
				//present(vc, animated: false)
			} else {
				errorMessage.isHidden = false
				errorMessage.text = "Wrong Username / Password"
			}
		}
	}
	
	//MARK: - func ============================================
	private func animate() {
		let animator1 = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut, animations: { [weak self] in
			self?.titleLabelLeadingAnchor?.constant = self?.leadingEdgeOnScreen ?? 0
			self?.view.layoutIfNeeded()
		})
		animator1.startAnimation()
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
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60)
		])
		titleLabelLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
		titleLabelLeadingAnchor?.isActive = true
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
		// error message
		view.addSubview(errorMessage)
		NSLayoutConstraint.activate([
			errorMessage.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
			errorMessage.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2)
		])
	}
}
