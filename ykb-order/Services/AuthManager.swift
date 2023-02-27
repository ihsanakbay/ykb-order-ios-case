//
//  AuthManager.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import Alamofire
import Foundation

protocol AuthService {
	func login(credentials: LoginCredentials, completion: @escaping (Result<LoginResponse, NetworkErrors>) -> ())
}

final class AuthManager: AuthService {
	func login(credentials: LoginCredentials, completion: @escaping (Result<LoginResponse, NetworkErrors>) -> ()) {
		let url = NetworkPaths.LOGIN_URL.withBaseUrl()

		let params = [
			"username": credentials.username,
			"password": credentials.password
		]

		AF.request(
			url,
			method: .post,
			parameters: params,
			encoder: JSONParameterEncoder.default).responseDecodable(of: LoginResponse.self) { response in
				switch response.result {
				case .success(let result):
					completion(.success(result))
				case .failure:
					completion(.failure(.invalidCredentials))
				}
			}
	}
}
