//
//  SearchPresenter.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

protocol ISearchPresener {
	func present(response: SearchModel.Response)
}

class SearchPresenter: ISearchPresener {
	
	// MARK: - Dependencies
	
	weak var viewController: ISearchViewController?
	
	// MARK: - Lifecycle

	init(viewController: ISearchViewController) {
		self.viewController = viewController
	}
	
	func present(response: SearchModel.Response) {
		switch response {
		case .success(let pictureData):
			let data = pictureData.imageData
			let image = UIImage(data: data) ?? UIImage()
			
			let picture = SearchModel.ViewModel.Picture(image: image, searchTerm: pictureData.searchTerm)
			let searchViewModel = SearchModel.ViewModel.success(picture)
			viewController?.render(viewModel: searchViewModel)
		case .failure(let error):
			let message: String
			if let error = error as? ImageFetcherError {
				message = self.handleError(error)
			} else {
				message = error.localizedDescription
			}
			let searchViewModel = SearchModel.ViewModel.failure(message)
			viewController?.render(viewModel: searchViewModel)
		case .save(let pictureSerchTerm):
			let message = L10n.SearchScene.saveMessage + pictureSerchTerm
			viewController?.render(viewModel: .saveMessage(message))
		}
	}
	
	private func handleError(_ error: ImageFetcherError) -> String {
		var message: String

		switch error {
		case .dataNotFound:
			message = L10n.SearchScene.ErrorMessage.dataNotFound
		case .invalidUrl:
			message = L10n.SearchScene.ErrorMessage.invalidUrl
		case .noInternetConnection:
			message = L10n.SearchScene.ErrorMessage.noInternetConnection
		}
		return message
	}
}
