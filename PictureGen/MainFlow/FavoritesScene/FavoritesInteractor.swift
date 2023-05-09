//
//  FavoritesInteractor.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

protocol IFavoritesInteractor {
	func makeRequest(request: FavoritesModel.Request)
}

class FavoritesInteractor: IFavoritesInteractor {
	
	// MARK: - Dependencies

	private var presenter: IFavoritesPresener?
	private var storageManager: Repository
	
	// MARK: - Lifecycle

	init(presenter: IFavoritesPresener, storageManager: Repository) {
		self.presenter = presenter
		self.storageManager = storageManager
	}
	
	func makeRequest(request: FavoritesModel.Request) {
		switch request {
		case .fetchData:
			storageManager.fetchData { [unowned self] pictures in
				self.presenter?.present(response: FavoritesModel.Response(pictureEntities: pictures))
			}
		case .deleteActionWasPerformed(let term):
			storageManager.delete(term)
			storageManager.fetchData { [unowned self] pictures in
				self.presenter?.present(response: FavoritesModel.Response(pictureEntities: pictures))
			}
		}
	}
}
