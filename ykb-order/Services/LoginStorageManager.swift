//
//  LoginStorageManager.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import Foundation

protocol LoginStorageService {
	var accessTokenKey: String { get }
	func setUserAccessToken(value: String)
	func getUserAccessToken() -> String?
}

final class LoginStorageManager: LoginStorageService {
	private let storage = UserDefaults.standard

	var accessTokenKey: String {
		return "ACCESS_TOKEN"
	}

	func setUserAccessToken(value: String) {
		storage.set(value, forKey: accessTokenKey)
	}

	func getUserAccessToken() -> String? {
		return storage.string(forKey: accessTokenKey)
	}
}
