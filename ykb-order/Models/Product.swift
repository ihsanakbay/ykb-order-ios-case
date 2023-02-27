//
//  Product.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import Foundation

struct ProductResponse: Codable {
	var products: [Product]
}

struct Product: Codable, Hashable {
	var id: Int
	var title: String
	var price: Double
	var stock: Int
	var images: [String]

	enum CodingKeys: String, CodingKey {
		case id
		case title
		case price
		case stock
		case images
	}
}
