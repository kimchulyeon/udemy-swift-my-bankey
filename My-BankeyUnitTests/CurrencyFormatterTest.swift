import Foundation
import XCTest

@testable import My_Bankey

class Test: XCTestCase {
	var formatter: CurrencyFormatter!

	override func setUp() {
		super.setUp()

		formatter = CurrencyFormatter()
	}

	func testBreakDollarsIntoCents() throws {
		let result = formatter.breakIntoDollarsAndCents(9232.23)
		XCTAssertEqual(result.0, "9,232")
		XCTAssertEqual(result.1, "23")
	}
}

