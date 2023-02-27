//
//  SceneDelegate.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: windowScene)

		let loginStorageService: LoginStorageService = LoginStorageManager()
		let rootViewModel = RootViewModel(loginStorageService: loginStorageService)
		let vc = RootViewController(viewModel: rootViewModel)
		window.rootViewController = UINavigationController(rootViewController: vc)
		self.window = window
		window.makeKeyAndVisible()
	}
}
