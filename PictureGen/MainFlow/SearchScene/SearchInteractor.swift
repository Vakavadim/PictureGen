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
	
	// MARK: - Lifecycle

	init(presenter: ISearchPresener) {
		self.presenter = presenter
	}
	
	func makeRequest(request: SearchModel.Request) {
		let response = SearchModel.Response(someData: " ")
		presenter?.present(response: response)
	}
}
