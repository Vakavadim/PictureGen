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
		let pictures: [FavoritesModel.ViewModel.Picture] = response.pictureEntities.map {
			mapPicture($0)
		}
		
		let viewModel = FavoritesModel.ViewModel(pictures: pictures)
		viewController?.render(viewModel: viewModel)
	}
	
	private func mapPicture(_ pictureEntitie: Picture) -> FavoritesModel.ViewModel.Picture {
		if let data = pictureEntitie.imageData {
			let image = UIImage(data: data) ?? UIImage()
			let term = pictureEntitie.requestString ?? " "
			
			return FavoritesModel.ViewModel.Picture(image: image, term: term)
		}
		return FavoritesModel.ViewModel.Picture(image: UIImage(), term: " ")
	}
}
