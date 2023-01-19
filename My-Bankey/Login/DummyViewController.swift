import UIKit

class DummyViewController: UIViewController {
	//MARK: - Properties
	let stackView: UIStackView = {
		let sv = UIStackView()
		sv.translatesAutoresizingMaskIntoConstraints = false
		sv.axis = .vertical
		sv.spacing = 20
		return sv
	}()
	let label: UILabel = {
		let lb = UILabel()
		lb.translatesAutoresizingMaskIntoConstraints = false
		lb.text = "Welcome"
		lb.font = UIFont.preferredFont(forTextStyle: .title1)
		return lb
	}()
	lazy var logoutButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Logout", for: .normal)
		btn.configuration = .filled()
		btn.addTarget(self, action: #selector(tappedLogout), for: .touchUpInside)
		return btn
	}()
	
	weak var delegate: LogoutDelegate?
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		layout()
	}
	
	//MARK: - func ============================================
	func layout() {
		stackView.addArrangedSubview(logoutButton)
		stackView.addArrangedSubview(label)
		
		view.addSubview(stackView)
		
		// stack view
		NSLayoutConstraint.activate([
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
	
	//MARK: - selector ============================================
	@objc func tappedLogout(sender: UIButton, forEvent event: UIEvent) {
		delegate?.didLogout()
	}
}

