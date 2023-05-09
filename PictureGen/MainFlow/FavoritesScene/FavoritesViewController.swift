//
//  FavoritesViewController.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

protocol IFavoritesViewController: AnyObject {
	func render(viewModel: FavoritesModel.ViewModel)
}

class FavoritesViewController: UITableViewController {
	
	// MARK: - Dependencies
	
	var interactor: IFavoritesInteractor?

	// MARK: - Private properties
	
	private var viewModel: FavoritesModel.ViewModel = FavoritesModel.ViewModel(pictures: [])

	// MARK: - View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		interactor?.makeRequest(request: .fetchData)
		setup()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		interactor?.makeRequest(request: .fetchData)
	}
	
	// MARK: - Private methods
	
	private func setup() {
		tableView.dataSource = self
		self.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
		view.backgroundColor = Theme.backgroundColor
	}
	
	private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
		let deleteAction = UIContextualAction(style: .destructive, title: L10n.FavoritesScene.delete) { [weak self] _, _, _ in
			let term = self?.viewModel.pictures[indexPath.row].term ?? " "
			self?.interactor?.makeRequest(request: .deleteActionWasPerformed(term))
		}
		return deleteAction
	}
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.pictures.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: FavoriteTableViewCell.reuseIdentifier,
			for: indexPath
		)
		guard let cell = cell as? FavoriteTableViewCell else { return UITableViewCell() }
		let picture = viewModel.pictures[indexPath.row]
		cell.configureCell(withImage: picture.image, text: picture.term)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		Sizes.M.height
	}
	
	override func tableView(
		_ tableView: UITableView,
		trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
	) -> UISwipeActionsConfiguration? {
		let deleteAction = deleteAction(at: indexPath)
		
		let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
		swipe.performsFirstActionWithFullSwipe = false
		return swipe
	}
}

extension FavoritesViewController: IFavoritesViewController {
	func render(viewModel: FavoritesModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
