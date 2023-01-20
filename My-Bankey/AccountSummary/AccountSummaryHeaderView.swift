import UIKit

class AccountSummaryHeaderView: UIView {

	@IBOutlet var contentView: UIView!

	override init(frame: CGRect) {
		super.init(frame: frame)

		commonInit()
	}

	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIView.noIntrinsicMetric, height: 144)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		commonInit()
	}
}

//MARK: - Layout
extension AccountSummaryHeaderView {
	func commonInit() {
		let bundle = Bundle(for: AccountSummaryHeaderView.self)
		bundle.loadNibNamed("AccountSummaryHeaderView", owner: self)

		addSubview(contentView)

		contentView.backgroundColor = appColor

		contentView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: self.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
		])
	}
}


