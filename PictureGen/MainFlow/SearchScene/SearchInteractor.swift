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
			let picture = getPictureFromLocalStorage(searchTerm: search.term)
			if  picture != nil {
				guard let imageData = picture?.imageData else {
					fatalError("no picture data in local storage")
				}
				guard let requestString = picture?.requestString else {
					fatalError("no requestString in local storage")
				}
				
				let pictureData = SearchModel.Response.PictureData(
					imageData: (imageData),
					searchTerm: (requestString)
				)
				let response = SearchModel.Response.success(pictureData)
				self.presenter?.present(response: response)
			} else {
				getPictureFromServer(searchTerm: search.path)
			}
		case .savePicture(picture: let picture):
			if let imageData = picture.image.jpegData(compressionQuality: 1.0) {
				storageManager.save(picture.searchTerm, imageData: imageData) { [unowned self] _ in
					self.presenter?.present(response: .save(picture.searchTerm))
				}
			}
		}
	}
	
	func getPictureFromServer(searchTerm: String) {
		self.imageDataFetcher.fetchImageData(from: searchTerm) { [unowned self] result in
			switch result {
			case .success(let data):
				let pictureData = SearchModel.Response.PictureData(imageData: data, searchTerm: searchTerm)
				let response = SearchModel.Response.success(pictureData)
				self.presenter?.present(response: response)
			case .failure(let error):
				let response = SearchModel.Response.failure(error)
				self.presenter?.present(response: response)
			}
		}
	}
	
	func getPictureFromLocalStorage(searchTerm: String) -> Picture? {
		var picture: Picture?
		storageManager.fetchData { pictures in
			picture = pictures.first(where: { pic in
				pic.requestString == searchTerm
			})
		}
		return picture
	}
}
