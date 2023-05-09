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
	
	// MARK: - Dependencies
	
	var presenter: ISearchPresener?
	private let imageDataFetcher: IImageDataFetcher
	private var storageManager: Repository
	
	// MARK: - Lifecycle
	
	init(
		presenter: ISearchPresener,
		imageDataFetcher: IImageDataFetcher,
		storageManager: Repository
	) {
		self.presenter = presenter
		self.imageDataFetcher = imageDataFetcher
		self.storageManager = storageManager
	}
	
	// MARK: - Internal methods
	
	func makeRequest(request: SearchModel.Request) {
		switch request {
		case .getImageWithTerm(searchTerm: let search):
//			DispatchQueue.main.async {
				self.imageDataFetcher.fetchImageData(from: search.path) { [unowned self] result in
					switch result {
					case .success(let data):
						let pictureData = SearchModel.Response.PictureData(imageData: data, searchTerm: search.term)
						let response = SearchModel.Response.success(pictureData)
						self.presenter?.present(response: response)
					case .failure(let error):
						let response = SearchModel.Response.failure(error)
						self.presenter?.present(response: response)
					}
				}
//			}
		case .savePicture(picture: let picture):
			if let imageData = picture.image.jpegData(compressionQuality: 1.0) {
				storageManager.save(picture.searchTerm, imageData: imageData) { [unowned self] _ in
					self.presenter?.present(response: .save(picture.searchTerm))
				}
			}
		}
	}
}
