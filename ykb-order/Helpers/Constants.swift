//
//  Constants.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import UIKit

typealias CartType = [Product: Int]

enum CustomIdentifiers {
	enum ListViewItem: String {
		case productListReuseId
		case cartListReuseId
		case priceLabel
	}
}

let SCREEN_SIZE = UIScreen.main.bounds

enum NetworkPaths: String {
	case BASE_URL = "https://dummyjson.com"
	case LOGIN_URL = "/auth/login"
	case PRODUCT_PATH = "/products"
}

extension NetworkPaths {
	func withBaseUrl() -> String {
		return "\(NetworkPaths.BASE_URL.rawValue)\(self.rawValue)"
	}
}

enum NetworkErrors: Error {
	case failedToDecode
	case badRequest
	case invalidCredentials

	var errorDescription: String {
		switch self {
		case .failedToDecode:
			return "Something went wrong"
		case .badRequest:
			return "Something went wrong"
		case .invalidCredentials:
			return "Invalid credentials"
		}
	}
}

// Dummy User for login
/*
 "username": "atuny0",
 "password": "9uQFF1Lh",
 */
