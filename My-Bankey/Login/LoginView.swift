import UIKit

class LoginView: UIView {

	//MARK: - Properties

	let usernameTextField: UITextField = {
		let tf = UITextField()
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.placeholder = "Username"
		tf.autocapitalizationType = .none
		return tf
	}()
	let passwordTextField: UITextField = {
		let tf = UITextField()
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.isSecureTextEntry = true
		tf.placeholder = "Password"
		tf.autocapitalizationType = .none
		return tf
	}()
	lazy var passwordToggleButton: UIButton = {
		let btn = UIButton(type: .custom)
		btn.setImage(UIImage(systemName: "eye.fill"), for: .normal)
		btn.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
		btn.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
		return btn
	}()
	private let inputFieldStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally
		stackView.spacing = 8
		return stackView
	}()
	private let dividerLine: UIView = {
		let line = UIView()
		line.translatesAutoresizingMaskIntoConstraints = false
		line.backgroundColor = .secondarySystemFill
		line.heightAnchor.constraint(equalToConstant: 1).isActive = true
		return line
	}()

	//MARK: - LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)

		usernameTextField.delegate = self
		passwordTextField.delegate = self

		style()
		configureUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - selector ============================================
	@objc func togglePasswordView() {
		passwordTextField.isSecureTextEntry.toggle()
		passwordToggleButton.isSelected.toggle()
	}
}

//MARK: - Layout & Style
extension LoginView {
	func style() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .secondarySystemBackground
		layer.cornerRadius = 5
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.2
		layer.shadowOffset = CGSize(width: 1, height: 1)
		layer.masksToBounds = false // clipsToBonds = true
	}
	func configureUI() {
		addSubview(inputFieldStackView)
		inputFieldStackView.addArrangedSubview(usernameTextField)
		inputFieldStackView.addArrangedSubview(dividerLine)
		inputFieldStackView.addArrangedSubview(passwordTextField)
		
		// input stack view
		NSLayoutConstraint.activate([
			inputFieldStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			inputFieldStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
			trailingAnchor.constraint(equalToSystemSpacingAfter: inputFieldStackView.trailingAnchor, multiplier: 1),
			bottomAnchor.constraint(equalToSystemSpacingBelow: inputFieldStackView.bottomAnchor, multiplier: 1)
		])
		// password toggle button
		passwordTextField.rightView = passwordToggleButton
		passwordTextField.rightViewMode = .always
	}
}


//MARK: - TextField Delegate
extension LoginView: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		usernameTextField.endEditing(true)
		passwordTextField.endEditing(true)
		return true
	}
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//		return textField.text != "" ? true : false
		return true
	}
	func textFieldDidEndEditing(_ textField: UITextField) {

	}
}


