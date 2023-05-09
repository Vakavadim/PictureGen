//
//  SearchPresenterSpy.swift
//  PictureGenTests
//
//  Created by Вадим Гамзаев on 09.05.2023.
//

import Foundation
@testable import PictureGen

class SearchPresenterSpy: ISearchPresener {
	
	// MARK: - Internal Properties
	
	private(set) var isCalledPresentWithSuccessCase = false
	private(set) var isCalledPresentWithFailureCase = false
	private(set) var isCalledPresentWithSaveCase = false
		
	// MARK: - Internal Methods
	
	func present(response: PictureGen.SearchModel.Response) {
		switch response {
		case .success(let data):
			isCalledPresentWithSuccessCase.toggle()
		case .failure(let error):
			isCalledPresentWithFailureCase = true
		case .save(let pricture):
			isCalledPresentWithSaveCase = true
		}
	}
}
