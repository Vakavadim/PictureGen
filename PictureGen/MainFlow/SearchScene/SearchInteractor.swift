//
//  SearchInteractor.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

protocol ISearchInteractor {
	func makeRequest(request: SearchModel.Request)
}

class SearchInteractor: ISearchInteractor {
	
	// MARK: - Internal properties
	
	var presenter: ISearchPresener?
	
	// MARK: - Private properties
	
	let imageDataFetcher: IImageDataFetcher
	
	// MARK: - Lifecycle
	
	init(presenter: ISearchPresener, imageDataFetcher: IImageDataFetcher) {
		self.presenter = presenter
		self.imageDataFetcher = imageDataFetcher
	}
	
	func makeRequest(request: SearchModel.Request) {
		let path = request.searchTerm.replacingOccurrences(of: " ", with: "+")
		DispatchQueue.main.async {
			self.imageDataFetcher.fetchImageData(from: path) { [unowned self] result in
				switch result {
				case .success(let data):
					let pictureData = SearchModel.Response.PictureData(imageData: data, searchTerm: request.searchTerm)
					let response = SearchModel.Response.success(pictureData)
					self.presenter?.present(response: response)
				case .failure(let error):
					let response = SearchModel.Response.failure(error as! ImageFetcherError) // swiftlint:disable:this force_cast
					self.presenter?.present(response: response)
				}
			}
		}
	}
}
