//
//  SearchSceneUITest.swift
//  PictureGenUITests
//
//  Created by Вадим Гамзаев on 09.05.2023.
//

import XCTest

final class SearchSceneTest: XCTestCase {
	
	func test_searchTest_must() {
		let app = XCUIApplication()
		let searchScreen = SearchScreenObject(app: app)
		
		app.launch()

		searchScreen
			.tapSearchTabBarButton()
			.isSearchScreen()
			.set(term: "Sometext")
			.save()
	}
}

