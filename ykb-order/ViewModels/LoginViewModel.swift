//
//  LoginViewModel.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import Foundation

final class LoginViewModel {
	private let service: AuthService
	private let storageService: LoginStorageService
	var errorMessage: String = ""
	var output: LoginOutput?

	init(service: AuthService, storageService: LoginStorageService) {
		self.service = service
		self.storageService = storageService
	}

	func login(credentials: LoginCredentials) {
		service.login(credentials: credentials) { result in
			switch result {
			case .success(let response):
				self.storageService.setUserAccessToken(value: response.token)
				self.output?.dismiss()
			case .failure(let error):
				print(error.errorDescription)
				self.errorMessage = error.errorDescription
				self.output?.showAlert(message: error.errorDescription)
			}
		}
	}

	func setDelegate(output: LoginOutput) {
		self.output = output
	}
}
