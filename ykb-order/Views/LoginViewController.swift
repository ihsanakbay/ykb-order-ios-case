//
//  LoginViewController.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import UIKit

class LoginViewController: UIViewController {
	private let titleLabel: UILabel = LabelFactory.build(
		text: "YKB-eCommerce",
		font: Fonts.bold(ofSize: 28),
		textColor: Colors.lightText)

	private let usernameTextField: UITextField = TextFieldFactory.build(
		placeholder: "Usernmame",
		autoCorrection: .no,
		autoCapitalized: .none)

	private let passwordTextField: UITextField = TextFieldFactory.build(
		placeholder: "Password",
		isSecure: true,
		autoCorrection: .no,
		autoCapitalized: .none)

	private lazy var loginButton: UIButton = {
		let button = ButtonFactory.build(
			text: "Login")
		button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
		return button
	}()

	private lazy var errorLabel: UILabel = {
		let label = LabelFactory.build(font: Fonts.semibold(ofSize: 14))
		label.textColor = Colors.error
		return label
	}()

	private let dummyInfoLabel: UILabel = LabelFactory.build(
		text: "Username: atuny0, Password: 9uQFF1Lh",
		font: Fonts.bold(ofSize: 14))

	private let viewModel: LoginViewModel = .init(service: AuthManager(), storageService: LoginStorageManager())

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.setDelegate(output: self)
		setupVC()
	}

	// MARK: Layout

	private func setupVC() {
		view.backgroundColor = .systemCyan
		navigationController?.navigationBar.isHidden = true
		[titleLabel,
		 usernameTextField,
		 passwordTextField,
		 loginButton,
		 dummyInfoLabel].forEach(view.addSubview(_:))

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
			make.centerX.equalTo(self.view)
		}

		usernameTextField.snp.makeConstraints { make in
			make.height.equalTo(50)
			make.top.equalTo(titleLabel.snp.bottom).offset(32)
			make.centerX.equalTo(self.view)
			make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
			make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
		}

		passwordTextField.snp.makeConstraints { make in
			make.height.equalTo(50)
			make.top.equalTo(usernameTextField.snp.bottom).offset(10)
			make.centerX.equalTo(self.view)
			make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
			make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
		}

		loginButton.snp.makeConstraints { make in
			make.height.equalTo(50)
			make.top.equalTo(passwordTextField.snp.bottom).offset(20)
			make.centerX.equalTo(self.view)
			make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
			make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
		}

		dummyInfoLabel.snp.makeConstraints { make in
			make.top.equalTo(loginButton.snp.bottom).offset(20)
			make.centerX.equalTo(self.view)
		}
	}

	@objc func loginTapped() {
		if let username = usernameTextField.text,
		   let password = passwordTextField.text
		{
			let credentials = LoginCredentials(
				username: username,
				password: password)

			viewModel.login(credentials: credentials)
		}
	}
}

// MARK: LoginOutput

extension LoginViewController: LoginOutput {
	func dismiss() {
		dismiss(animated: true)
	}

	func showAlert(message: String) {
		showAlertController(message: message)
	}

	private func showAlertController(message: String) {
		let alert = UIAlertController(
			title: "Error",
			message: message,
			preferredStyle: .alert)

		alert.addAction(UIAlertAction(title: "OK", style: .default))
		present(alert, animated: true)
	}
}
