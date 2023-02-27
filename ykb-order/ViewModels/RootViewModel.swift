//
//  RootViewModel.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import Foundation

final class RootViewModel {
	private let loginStorageService: LoginStorageService
	weak var output: RootViewModelOutput?

	init(loginStorageService: LoginStorageService) {
		self.loginStorageService = loginStorageService
	}

	func checkAuth() {
		if let accessToken = loginStorageService.getUserAccessToken(),
		   !accessToken.isEmpty
		{
			output?.showMainPage()
		} else {
			output?.showLoginPage()
		}
	}
}
