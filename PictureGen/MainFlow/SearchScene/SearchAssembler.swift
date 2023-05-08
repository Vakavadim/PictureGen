//
//  SearchAssembler.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

class SearchAssembler {
	
	// MARK: - Internal Methods

	static func assembly() -> UIViewController {
		let searchViewController = SearchViewController()
		let searchPresentor = SearchPresenter(viewController: searchViewController)
		let searchIteractor = SearchInteractor(
			presenter: searchPresentor,
			imageDataFetcher: ImageDataFetcher()
		)
		
		searchViewController.interactor = searchIteractor
		
		return searchViewController
	}
}
