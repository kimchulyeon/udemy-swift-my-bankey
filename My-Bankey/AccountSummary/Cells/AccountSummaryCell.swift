import UIKit

class AccountSummaryCell: UITableViewCell {
	
	enum AccountType: String {
		case Banking
		case CreditCard
		case Investment
	}
	
	struct ViewModel {
		let accountType: AccountType
		let accountName: String
		let balance: Decimal

		var balanceAsAttributedString: NSAttributedString {
			return CurrencyFormatter().makeAttributedCurrency(balance)
		}
	}
	let viewModel: ViewModel? = nil
	
	//MARK: - Properties
	static let reuseID = "AccountSummaryCell"
	static let rowHeight: CGFloat = 112
	
	let typeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .caption1)
		label.adjustsFontForContentSizeCategory = true
		label.text = "Account type"
		return label
	}()
	let divider: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemTeal
 		return view
	}()
	let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Account name"
		label.adjustsFontForContentSizeCategory = true
		label.font = UIFont.preferredFont(forTextStyle: .body)
		return label
	}()
	
	let balanceStackView: UIStackView = {
		let sv = UIStackView()
		sv.translatesAutoresizingMaskIntoConstraints = false
		sv.axis = .vertical
		sv.spacing = 0
		return sv
	}()
	let balanceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textAlignment = .right
		label.text = "Some balance"
		return label
	}()
	lazy var balanceAmountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .right
		label.attributedText = makeFormattedBalance(dollars: "XXX.XX", cents: "XX")
		return label
	}()
	
	let chevronImageView: UIImageView = {
		let img = UIImageView()
		img.translatesAutoresizingMaskIntoConstraints = false
		img.image = UIImage(systemName: "chevron.right")?.withTintColor(appColor, renderingMode: .alwaysOriginal)
		return img
	}()
	
	//MARK: - Lifecycle
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - func ============================================
	private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
		let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
		let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
		let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
		
		let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
		let dollarString = NSMutableAttributedString(string: dollars, attributes: dollarAttributes)
		let centString = NSMutableAttributedString(string: cents, attributes: centAttributes)
		
		rootString.append(dollarString)
		rootString.append(centString)
		
		return rootString
	}
	
	func configure(with vm: ViewModel) {
		typeLabel.text = vm.accountType.rawValue
		nameLabel.text = vm.accountName
		balanceAmountLabel.attributedText = vm.balanceAsAttributedString
		
		switch vm.accountType {
		case .Banking:
			divider.backgroundColor = appColor
			balanceLabel.text = "Current balance"
		case .CreditCard:
			divider.backgroundColor = .systemOrange
			balanceLabel.text = "Balance"
		case .Investment:
			divider.backgroundColor = .systemPurple
			balanceLabel.text = "Value"
		}
	}
}

//MARK: - EXT + configureUI
extension AccountSummaryCell {
	private func configureUI() {
		contentView.addSubview(typeLabel)
		contentView.addSubview(divider)
		contentView.addSubview(nameLabel)
		
		balanceStackView.addArrangedSubview(balanceLabel)
		balanceStackView.addArrangedSubview(balanceAmountLabel)
		
		contentView.addSubview(balanceStackView)
		contentView.addSubview(chevronImageView)
		
		// type label
		NSLayoutConstraint.activate([
			typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
		])
		// divider line
		NSLayoutConstraint.activate([
			divider.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
			divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			divider.heightAnchor.constraint(equalToConstant: 4),
			divider.widthAnchor.constraint(equalToConstant: 60),
		])
		// name label
		NSLayoutConstraint.activate([
			nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			nameLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
		])
		// balance stack view
		NSLayoutConstraint.activate([
			balanceStackView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 0),
			balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
			balanceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
		])
		// chevron image
		NSLayoutConstraint.activate([
			chevronImageView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 8),
			chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
		])
	}
}

