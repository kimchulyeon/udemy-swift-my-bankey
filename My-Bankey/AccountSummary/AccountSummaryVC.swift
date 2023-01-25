import UIKit

class AccountSummaryVC: UIViewController {
	//MARK: - Properties
	lazy var tableView: UITableView = {
		let tv = UITableView()
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.delegate = self
		tv.dataSource = self
		return tv
	}()
	let header = AccountSummaryHeaderView(frame: .zero)

	struct Profile {
		let firstName: String
		let lastName: String
	}
	var profile: Profile?
	var accounts: [AccountSummaryCell.ViewModel] = []

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
		setupTableHeaderView()
		fetchAccounts()
	}

	//MARK: - func ============================================
	func setup() {
		setupTableView()
	}

	func setupTableView() {
		tableView.backgroundColor = appColor
		tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
		tableView.rowHeight = AccountSummaryCell.rowHeight
		tableView.tableFooterView = UIView()

		view.addSubview(tableView)
		// table view
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
		])
	}

	func setupTableHeaderView() {
		var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		size.width = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
		//size.width = UIScreen.main.bounds.width ❌
		header.frame.size = size

		tableView.tableHeaderView = header
	}
}


//MARK: - delegate ============================================
extension AccountSummaryVC: UITableViewDelegate {

}

extension AccountSummaryVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return accounts.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard !accounts.isEmpty else { return UITableViewCell() }
		guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as? AccountSummaryCell else { return UITableViewCell() }
		cell.configure(with: accounts[indexPath.row])
		return cell
	}
}


//MARK: - network ============================================
extension AccountSummaryVC {
	private func fetchAccounts() {
		let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings", balance: 943213.61)
		let chequing = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "No-Fee All-In-Chequing", balance: 1213.32)
		let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Visa Avion Card", balance: 213.15)
		let mastercard = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Student", balance: 43.47)
		let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
		let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Growth Fund", balance: 15000.00)
		
		accounts.append(savings)
		accounts.append(chequing)
		accounts.append(visa)
		accounts.append(mastercard)
		accounts.append(investment1)
		accounts.append(investment2)
	}
}
