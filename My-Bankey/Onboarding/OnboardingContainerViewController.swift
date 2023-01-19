import UIKit

//MARK: - protocol ============================================
protocol OnboardingContainerViewControllerDelegate: AnyObject {
	func didFinishOnboarding(_ sender: OnboardingContainerViewController)
}

class OnboardingContainerViewController: UIViewController {

	//MARK: - properties ============================================
	let pageViewController: UIPageViewController
	var pages = [UIViewController]()
	var currentVC: UIViewController
	lazy var closeButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Close", for: .normal)
		btn.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
		return btn
	}()
	lazy var doneButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Done", for: .normal)
		btn.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
		return btn
	}()

	weak var delegate: OnboardingContainerViewControllerDelegate?

	//MARK: - lifecycle ============================================
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

		let page1 = OnboardingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989")
		let page2 = OnboardingViewController(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
		let page3 = OnboardingViewController(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com")

		pages.append(page1)
		pages.append(page2)
		pages.append(page3)

		currentVC = pages.first!

		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		configurePageView()
		layout()
	}

	//MARK: - func ============================================
	func layout() {
		view.backgroundColor = .lightGray
		view.addSubview(closeButton)
		view.addSubview(doneButton)

		// page view controller
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
			view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
			view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
		])

		// close button
		NSLayoutConstraint.activate([
			closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
		])
		
		// done button
		NSLayoutConstraint.activate([
			doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
		])
	}

	func configurePageView() {
		addChild(pageViewController)
		view.addSubview(pageViewController.view)
		pageViewController.didMove(toParent: self)

		pageViewController.dataSource = self
		
		pageViewController.view.translatesAutoresizingMaskIntoConstraints = false

		pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
		currentVC = pages.first!
	}
	

	//MARK: - selector ============================================
	@objc func closeTapped() {
		delegate?.didFinishOnboarding(self)
	}
	@objc func doneTapped() {
		delegate?.didFinishOnboarding(self)
	}
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		return getPreviousViewController(from: viewController)
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		return getNextViewController(from: viewController)
	}

	private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
		guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
		currentVC = pages[index - 1]
		return pages[index - 1]
	}

	private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
		guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
		currentVC = pages[index + 1]
		return pages[index + 1]
	}

	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return pages.count
	}

	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		return pages.firstIndex(of: self.currentVC) ?? 0
	}
}
