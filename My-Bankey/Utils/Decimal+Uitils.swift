//
//  Decimal+Uitils.swift
//  My-Bankey
//
//  Created by chulyeon kim on 2023/01/25.
//

import Foundation

extension Decimal {
	var doubleValue: Double {
		return NSDecimalNumber(decimal: self).doubleValue
	}
}
