//
//  ProductListViewModel.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import Combine
import Foundation

final class ProductListViewModel {
	enum Input {
		case viewDidLoad
		case onProductCellEvent(event: ProductCellEvent, product: Product)
	}

	enum Output {
		case setProducts(products: [Product])
		case updateView(cart: CartType, numberOfItemsInCart: Int, productQuantities: [Int: Int])
	}

	private let service: ProductService
	private let storageService: LoginStorageService
	private let output = PassthroughSubject<Output, Never>()
	private var cancellables = Set<AnyCancellable>()

	@Published private var cart: CartType = [:]

	init(service: ProductService = ProductManager(),
	     storageService: LoginStorageService = LoginStorageManager())
	{
		self.service = service
		self.storageService = storageService

		observe()
	}

	func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
		input.sink { [unowned self] event in
			switch event {
			case .viewDidLoad:
				service.getProducts { result in
					switch result {
					case .success(let products):
						self.output.send(.setProducts(products: products))
						self.output.send(.updateView(
							cart: self.itemsInCart,
							numberOfItemsInCart: self.numberOfItemsInCart,
							productQuantities: self.productQuantities))
					case .failure(let error):
						print(error.errorDescription)
					}
				}

			case .onProductCellEvent(let event, let product):
				switch event {
				case .quantityDidChange(value: let value):
					cart[product] = value
					output.send(.updateView(
						cart: itemsInCart,
						numberOfItemsInCart: numberOfItemsInCart,
						productQuantities: productQuantities))
				}
			}
		}
		.store(in: &cancellables)
		return output.eraseToAnyPublisher()
	}

	private func observe() {
		$cart.dropFirst().sink { dictionary in
			dictionary.forEach { key, value in
				print("\(key.title) - \(value)")
			}
		}.store(in: &cancellables)
	}

	private var numberOfItemsInCart: Int {
		cart.reduce(0) { $0 + $1.value }
	}

	private var itemsInCart: CartType {
		cart.forEach { key, value in
			if value == 0 {
				self.cart.removeValue(forKey: key)
			}
		}
		return cart
	}

	private var productQuantities: [Int: Int] {
		var temp = [Int: Int]()
		cart.forEach { key, value in
			temp[key.id] = value
		}
		return temp
	}

	func logout() {
		storageService.setUserAccessToken(value: "")
	}
}

extension ProductListViewModel: CartOutput {
	func order(cart: CartType) {
		/// In here, We can do what we want after order is completed
		cart.forEach { key, value in
			print(key)
			print(value)
		}
		self.cart.removeAll()
		output.send(.updateView(
			cart: itemsInCart,
			numberOfItemsInCart: numberOfItemsInCart,
			productQuantities: productQuantities))
	}
}
