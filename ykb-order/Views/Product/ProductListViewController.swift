//
//  ProductListViewController.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import Combine
import SnapKit
import UIKit

class ProductListViewController: UIViewController {
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: CustomIdentifiers.ListViewItem.productListReuseId.rawValue)
		tableView.rowHeight = 120
		tableView.separatorStyle = .none
		return tableView
	}()

	private var numberOfItemsInCart: Int = 0
	private var productQuantities: [Int: Int] = [:]
	private var products: [Product] = []
	private var cart: [Product: Int] = [:]

	private let viewModel = ProductListViewModel()

	private let output = PassthroughSubject<ProductListViewModel.Input, Never>()
	private var cancellables = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupVC()
		observe()
		output.send(.viewDidLoad)
	}

	private func setupVC() {
		view.backgroundColor = .systemBackground
		tableView.delegate = self
		tableView.dataSource = self

		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: Icons.cart),
			style: .plain,
			target: self,
			action: #selector(cartTapped)
		)

		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: Icons.logout),
			style: .plain,
			target: self,
			action: #selector(logoutTapped)
		)

		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalTo(view.safeAreaLayoutGuide)
		}
	}

	private func observe() {
		viewModel.transform(input: output.eraseToAnyPublisher())
			.receive(on: DispatchQueue.main)
			.sink { [unowned self] event in
				switch event {
				case .setProducts(products: let products):
					self.products = products
				case .updateView(cart: let itemsInCart, numberOfItemsInCart: let numberOfItemsInCart, productQuantities: let productQuantities):
					self.cart = itemsInCart
					self.numberOfItemsInCart = numberOfItemsInCart
					self.productQuantities = productQuantities
					self.tableView.reloadData()
				}
			}
			.store(in: &cancellables)
	}

	@objc func cartTapped() {
		let vc = CartViewController(cart: cart, output: viewModel)
		vc.navigationItem.title = "Your Cart"
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc func logoutTapped() {
		viewModel.logout()
		dismiss(animated: true, completion: nil)
	}
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return products.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell: ProductTableViewCell = tableView.dequeueReusableCell(
			withIdentifier: CustomIdentifiers.ListViewItem.productListReuseId.rawValue,
			for: indexPath
		) as? ProductTableViewCell
		else { return UITableViewCell() }

		/// The reason I added this was because cell contentView didn't allow pressing the buttons
		cell.contentView.isUserInteractionEnabled = false

		let product = products[indexPath.item]

		cell.setProduct(
			product: product,
			cartQuantity: productQuantities[product.id] ?? 0
		)

		cell.eventPublisher.sink { [weak self] event in
			self?.output.send(.onProductCellEvent(event: event, product: product))
		}
		.store(in: &cell.cancellables)

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let product = products[indexPath.item]
		let detailVC = ProductDetailViewController(product: product)
		navigationController?.pushViewController(detailVC, animated: true)
	}
}
