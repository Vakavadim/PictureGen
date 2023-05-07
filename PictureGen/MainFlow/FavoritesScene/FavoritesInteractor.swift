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
	
	// MARK: - Internal properties
	
	var presenter: IFavoritesPresener?
	
	// MARK: - Lifecycle

	init(presenter: IFavoritesPresener) {
		self.presenter = presenter
	}
	
	func makeRequest(request: FavoritesModel.Request) {
		let response = FavoritesModel.Response(someData: " ")
		presenter?.present(response: response)
	}
}
