//
//  FavoritesAssembler.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

class FavoritesAssembler {

	// MARK: - Internal Methods

	static func assembly(storageManager: Repository) -> UIViewController {
		let favoritesViewController = FavoritesViewController()
		
		let favoritesPresentor = FavoritesPresenter(viewController: favoritesViewController)
		let favoritesIteractor = FavoritesInteractor(presenter: favoritesPresentor, storageManager: storageManager)
		
		favoritesViewController.interactor = favoritesIteractor
		
		return favoritesViewController
	}
}
