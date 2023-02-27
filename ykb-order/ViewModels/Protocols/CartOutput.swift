//
//  CartViewModelOutput.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import Foundation

protocol CartOutput: AnyObject {
	func order(cart: CartType)
}
