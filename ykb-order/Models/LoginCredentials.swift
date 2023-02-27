//
//  LoginCredentials.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import Foundation

struct LoginCredentials: Codable {
	var username: String
	var password: String
}

struct LoginResponse: Codable {
	var id: Int
	var username: String
	var token: String
}
