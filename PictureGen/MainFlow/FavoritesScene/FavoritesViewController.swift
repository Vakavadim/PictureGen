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

class FavoritesViewController: UIViewController {
	
	// MARK: - Internal Properties
	
	var viewModel: FavoritesModel.ViewModel = FavoritesModel.ViewModel(someData: " ")
	var interactor: IFavoritesInteractor?

	// MARK: - Private properties
	
	// MARK: Object lifecycle
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .blue
	}
}

extension FavoritesViewController: IFavoritesViewController {
	func render(viewModel: FavoritesModel.ViewModel) {
		self.viewModel = viewModel
	}
}
