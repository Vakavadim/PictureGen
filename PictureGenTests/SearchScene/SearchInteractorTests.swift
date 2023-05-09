//
//  PictureGenTests.swift
//  PictureGenTests
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import XCTest
@testable import PictureGen

final class SearchInteractorTests: XCTestCase {
	
	// MARK: - Internal Properties
	
	private let presenter = SearchPresenterSpy()
	private let imageDataFetcher = MockImageDataFetcher()
	private let storageManager = StorageManagerStub()
	
	// MARK: - Internal Methods
	
	func test_request_withSuccesRequest_shouldCalledPresentWithSuccessCase() {
		let sut = makeSut()
		
		let searchTerm = SearchModel.Request.SearchTerm(term: "succes")
		sut.makeRequest(request: .getImageWithTerm(searchTerm: searchTerm))
			
		XCTAssertTrue(presenter.isCalledPresentWithSuccessCase, "Не вызван  presenter.present(:)")
	}
	
	func test_request_withFailureRequest_shouldCalledPresentWithFailureCase() {
		let sut = makeSut()
		
		let searchTerm = SearchModel.Request.SearchTerm(term: "failure")
		sut.makeRequest(request: .getImageWithTerm(searchTerm: searchTerm))
			
		XCTAssertTrue(presenter.isCalledPresentWithFailureCase, "Не вызван  presenter.present(:)")
	}
}

// MARK: - Making sut

private extension SearchInteractorTests {
	func makeSut() -> SearchInteractor {
		SearchInteractor(
			presenter: presenter,
			imageDataFetcher: imageDataFetcher,
			storageManager: storageManager
		)
	}
}
