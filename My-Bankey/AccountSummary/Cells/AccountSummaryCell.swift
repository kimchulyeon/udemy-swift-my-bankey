import UIKit

class AccountSummaryCell: UITableViewCell {
	
	//MARK: - Properties
	static let reuseID = "AccountSummaryCell"
	static let rowHeight: CGFloat = 100
	
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
	let balanceAmountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .right
		label.text = "$929,466.54"
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

