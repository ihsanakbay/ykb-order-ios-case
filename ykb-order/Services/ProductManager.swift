//
//  ProductManager.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import Alamofire
import Foundation

protocol ProductService {
	func getProducts(completion: @escaping (Result<[Product], NetworkErrors>) -> ())
	func orderProducts(cart: CartType, completion: @escaping (Result<Bool, NetworkErrors>) -> ())
}

final class ProductManager: ProductService {
	func getProducts(completion: @escaping (Result<[Product], NetworkErrors>) -> ()) {
		let url = NetworkPaths.PRODUCT_PATH.withBaseUrl()
		AF.request(url, method: .get).validate().responseDecodable(of: ProductResponse.self) { response in
			guard let result = response.value else {
				completion(.failure(.failedToDecode))
				return
			}
			completion(.success(result.products))
		}
	}

	func orderProducts(cart: CartType, completion: @escaping (Result<Bool, NetworkErrors>) -> ()) {
		/// We can send a request  to our api for order confirmation but we don't have that api.
		/// Thats why we simply mock the response
		completion(.success(true))
	}
}
