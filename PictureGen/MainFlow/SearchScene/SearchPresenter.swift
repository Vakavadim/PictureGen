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
		let viewModel = SearchModel.ViewModel(someData: " ")
		viewController?.render(viewModel: viewModel)
	}
}
