import UIKit

class OnboardingViewController: UIViewController {
	//MARK: - Properties
	let heroImageName: String
	let titleText: String

	let stackView: UIStackView = {
		let sv = UIStackView()
		sv.translatesAutoresizingMaskIntoConstraints = false
		sv.axis = .vertical
		sv.spacing = 20
		return sv
	}()
	lazy var imageView: UIImageView = {
		let img = UIImageView()
		img.translatesAutoresizingMaskIntoConstraints = false
		img.contentMode = .scaleAspectFit
		img.image = UIImage(named: self.heroImageName)
		return img
	}()
	lazy var label: UILabel = {
		let lb = UILabel()
		lb.translatesAutoresizingMaskIntoConstraints = false
		lb.text = self.titleText
		lb.font = UIFont.preferredFont(forTextStyle: .title3)
		lb.numberOfLines = 0
		lb.adjustsFontForContentSizeCategory = false
		lb.textAlignment = .center
		return lb
	}()

	//MARK: - Lifecycle
	init(heroImageName: String, titleText: String) {
		self.heroImageName = heroImageName
		self.titleText = titleText

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .systemBackground
		configure()
	}

	//MARK: - func ============================================
	func configure() {
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(label)
		view.addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
		])
	}
}

