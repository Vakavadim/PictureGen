//
//  FavoritesPresenter.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol IFavoritesPresener {
	func present(response: FavoritesModel.Response)
}

class FavoritesPresenter: IFavoritesPresener {
	
	// MARK: - Internal properties
	
	weak var viewController: IFavoritesViewController?
	
	// MARK: - Lifecycle

	init(viewController: IFavoritesViewController) {
		self.viewController = viewController
	}
	
	func present(response: FavoritesModel.Response) {
		let viewModel = FavoritesModel.ViewModel(someData: " ")
		viewController?.render(viewModel: viewModel)
	}
}
