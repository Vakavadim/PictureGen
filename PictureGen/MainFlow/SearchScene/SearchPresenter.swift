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
	
	// MARK: - Internal properties
	
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
			let message = self.handleError(error)
			let searchViewModel = SearchModel.ViewModel.failure(message)
			viewController?.render(viewModel: searchViewModel)
		}
	}
	
	private func handleError(_ error: ImageFetcherError) -> String {
		var message: String

		switch error {
		case .dataNotFound:
			message = "net data"
		case .invalidUrl:
			message = "net url"
		}
		return message
	}
}
