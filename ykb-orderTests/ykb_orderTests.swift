//
//  ykb_orderTests.swift
//  ykb-orderTests
//
//  Created by İhsan Akbay on 26.02.2023.
//

import XCTest
@testable import ykb_order

final class ykb_orderTests: XCTestCase {
	private var sut: RootViewModel!
	private var loginStorageService: MockLoginStorageService!
	private var output: MockRootViewModelOutput!

	override func setUpWithError() throws {
		loginStorageService = MockLoginStorageService()
		sut = RootViewModel(loginStorageService: loginStorageService)
		output = MockRootViewModelOutput()

		sut.output = output
	}

	override func tearDownWithError() throws {
		sut = nil
		loginStorageService = nil
	}

	func testShowLogin_whenLoginStorageReturnsEmptyAccessToken() throws {
		loginStorageService.storage = [:]
		sut.checkAuth()
		XCTAssertEqual(output.checkArray.first, .login)
	}
	
	func testShowLogin_whenLoginStorageReturnsEmptyString() throws {
		loginStorageService.storage["ACCESS_TOKEN"] = ""
		sut.checkAuth()
		XCTAssertEqual(output.checkArray.first, .login)
	}

	func testShowMain_whenLoginStorageReturnsAccessToken() throws {
		loginStorageService.storage["ACCESS_TOKEN"] = "12345asdfg"
		sut.checkAuth()
		XCTAssertEqual(output.checkArray.first, .main)
	}
}

class MockLoginStorageService: LoginStorageService {
	var accessTokenKey: String {
		return "ACCESS_TOKEN"
	}

	var storage: [String: String] = [:]

	func setUserAccessToken(value: String) {
		storage[accessTokenKey] = value
	}

	func getUserAccessToken() -> String? {
		return storage[accessTokenKey]
	}
}

class MockRootViewModelOutput: RootViewModelOutput {
	enum Check {
		case login
		case main
	}

	var checkArray: [Check] = []

	func showLoginPage() {
		checkArray.append(.login)
	}

	func showMainPage() {
		checkArray.append(.main)
	}
}
