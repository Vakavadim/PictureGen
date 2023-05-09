//
//  SearchScreenObject.swift
//  PictureGenUITests
//
//  Created by Вадим Гамзаев on 09.05.2023.
//

import XCTest

class SearchScreenObject: BaseScreenObject {
	
	enum Search {
		static let imageView = "searchSceneImageView"
		static let saveButton = "searchSceneSaveButton"
		static let loader = "searchSceneActivityIndicator"
		static let infoLabel = "searchSceneInfoLabel"
	}
	
	// MARK: - Private properties
	
	private lazy var searchBar = app.searchFields.firstMatch
	private lazy var imageView = app.images [Search.imageView]
	private lazy var saveButton = app.buttons [Search.saveButton]
	private lazy var loader = app.activityIndicators [Search.loader]
	private lazy var infoLabel = app.staticTexts [Search.infoLabel]
	private lazy var searchTabBarButton = app.tabBars.buttons["Search"]
	
	// MARK: - ScreenObject Methods
	
	@discardableResult
	func tapSearchTabBarButton() -> Self {
		assert(searchTabBarButton, [.exists])
		searchTabBarButton.tap()
		return self
	}
	
	@discardableResult
	func isSearchScreen() -> Self {
		assert(searchBar, [.exists])
		assert(imageView, [.exists])
		assert(saveButton, [.exists])
		assert(infoLabel, [.exists])
		return self
	}
	
	@discardableResult
	func set(term: String) -> Self {
		assert(searchBar, [.exists])
		assert(imageView, [.exists])
		searchBar.tap()
		searchBar.typeText(term)
		imageView.tap()
		return self
	}
	
	@discardableResult
	func save() -> Self {
		assert(saveButton, [.exists])
		saveButton.tap()
		return self
	}
}
