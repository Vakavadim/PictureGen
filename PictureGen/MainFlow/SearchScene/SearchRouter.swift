//
//  SearchRouter.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 09.05.2023.
//

import UIKit

protocol ISearchRouter {
	func showError(message: String)
	func showMessage(message: String)
}

final class SearchRouter: ISearchRouter {

	private weak var searchViewController: UIViewController?

	internal init(searchViewController: UIViewController) {
		self.searchViewController = searchViewController
	}

	func showError(message: String) {
		let alert: UIAlertController
		alert = UIAlertController(
			title: L10n.SearchScene.error,
			message: message,
			preferredStyle: UIAlertController.Style.alert
		)
		let action = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(action)
		searchViewController?.present(alert, animated: true, completion: nil)
	}
	
	func showMessage(message: String) {
		let alert: UIAlertController
		alert = UIAlertController(
			title: " ",
			message: message,
			preferredStyle: UIAlertController.Style.alert
		)
		let action = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(action)
		searchViewController?.present(alert, animated: true, completion: nil)
	}
}
