//
//  SearchAssembler.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

class SearchAssembler {
	
	// MARK: - Internal Methods

	static func assembly(storageManager: Repository) -> UIViewController {
		let searchViewController = SearchViewController()
		let searchPresentor = SearchPresenter(viewController: searchViewController)
		let searchIteractor = SearchInteractor(
			presenter: searchPresentor,
			imageDataFetcher: ImageDataFetcher(),
			storageManager: storageManager
		)
		let searchRouter = SearchRouter(searchViewController: searchViewController)
		
		searchViewController.interactor = searchIteractor
		searchViewController.router = searchRouter
		
		return searchViewController
	}
}
