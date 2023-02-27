//
//  RootViewController.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import UIKit

class RootViewController: UIViewController {
	private let viewModel: RootViewModel

	init(viewModel: RootViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		viewModel.output = self
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		viewModel.checkAuth()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		viewModel.checkAuth()
	}
}

// MARK: RootViewModelOutput Delegation

extension RootViewController: RootViewModelOutput {
	func showLoginPage() {
		let loginVC = LoginViewController()
		loginVC.modalPresentationStyle = .fullScreen
		navigationController?.present(loginVC, animated: true)
	}

	func showMainPage() {
		let mainVC = createNavController(for: ProductListViewController(), title: "Products")
		mainVC.modalPresentationStyle = .fullScreen
		navigationController?.present(mainVC, animated: true)
	}

	fileprivate func createNavController(
		for rootViewController: UIViewController,
		title: String) -> UIViewController
	{
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.navigationBar.prefersLargeTitles = false
		rootViewController.navigationItem.title = title
		return navController
	}
}
