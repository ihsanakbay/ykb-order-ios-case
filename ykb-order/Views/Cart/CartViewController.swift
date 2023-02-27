//
//  CartViewController.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import UIKit

class CartViewController: UIViewController {
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CustomIdentifiers.ListViewItem.cartListReuseId.rawValue)
		tableView.rowHeight = 120
		tableView.separatorStyle = .none
		return tableView
	}()

	private var cart: [Product: Int] = [:]
	private let viewModel: CartViewModel? = CartViewModel(service: ProductManager())
	weak var output: CartOutput?

	init(cart: [Product: Int], output: CartOutput?) {
		self.cart = cart
		self.output = output
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel?.setDelegate(output: output)
		setupVC()
	}

	private func setupVC() {
		view.backgroundColor = .systemBackground
		tableView.delegate = self
		tableView.dataSource = self

		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Order",
			style: .plain,
			target: self,
			action: #selector(doneTapped)
		)
		
		if cart.isEmpty {
			navigationItem.rightBarButtonItem?.isEnabled = false
		}

		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalTo(view.safeAreaLayoutGuide)
		}
	}

	@objc func doneTapped() {
		if !cart.isEmpty {
			viewModel?.orderAndClose(cart: cart)
			navigationController?.popViewController(animated: true)
		}
	}
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cart.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomIdentifiers.ListViewItem.cartListReuseId.rawValue, for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
		cell.contentView.isUserInteractionEnabled = false
		let product = Array(cart)[indexPath.item].key
		let quantity = Array(cart)[indexPath.item].value
		cell.setProduct(product: product, cartQuantity: quantity)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
