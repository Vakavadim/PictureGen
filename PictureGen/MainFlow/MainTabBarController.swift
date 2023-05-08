//
//  MainTabBarController.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	// MARK: - Internal properties
	
	let searchViewController: UIViewController
	let favoritesViewController: UIViewController
	
	// MARK: - Lifecycle
	
	init(searchViewController: UIViewController, favoritesViewController: UIViewController) {
		self.searchViewController = searchViewController
		self.favoritesViewController = favoritesViewController
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tabBar.tintColor = Theme.accentColor
		
		viewControllers = [
			generateViewController(
				rootViewController: searchViewController,
				image: Asset.searchIcon.image,
				title: L10n.SearchScene.title
			),
			generateViewController(
				rootViewController: favoritesViewController,
				image: Asset.favoriteIcon.image,
				title: L10n.FavoritesScene.title
			)
		]
	}
	
	// MARK: - Private methods
	
	private func generateViewController(
		rootViewController: UIViewController,
		image: UIImage,
		title: String
	) -> UIViewController {
		let navigationVC = UINavigationController(rootViewController: rootViewController)
		navigationVC.tabBarItem.image = image
		navigationVC.tabBarItem.title = title
		rootViewController.navigationItem.title = title
		navigationVC.navigationBar.prefersLargeTitles = true

		return navigationVC
	}
}
