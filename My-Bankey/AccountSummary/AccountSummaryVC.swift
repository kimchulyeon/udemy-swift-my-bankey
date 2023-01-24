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
	
	let games = [
		"Pacman",
		"Space Invaders",
		"Space Patrol"
	]
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		setupTableHeaderView()
	}
	
	//MARK: - func ============================================
	func setup() {
		setupTableView()
	}
	
	func setupTableView() {
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
		let header = AccountSummaryHeaderView(frame: .zero)
		
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
		return games.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as? AccountSummaryCell else { return UITableViewCell() }
		return cell
	}
}
