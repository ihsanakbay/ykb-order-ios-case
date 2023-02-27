//
//  CartViewModel.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import Foundation

final class CartViewModel {
	private var output: CartOutput?
	private var cart: CartType = [:]

	private let service: ProductService

	init(output: CartOutput? = nil, service: ProductService) {
		self.output = output
		self.service = service
	}

	func setDelegate(output: CartOutput?) {
		self.output = output
	}

	func orderAndClose(cart: CartType) {
		service.orderProducts(cart: cart) { result in
			switch result {
			case .success:
				print("Order completed Successfully")
			case .failure(let error):
				print(error.errorDescription)
			}
		}
		/// If we want to do something in productlist. we can send the cart here
		output?.order(cart: cart)
	}
}
