//
//  SceneDelegate.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		window.rootViewController = assamble()

		window.makeKeyAndVisible()

		self.window = window
	}
	
	private func assamble() -> UITabBarController {
		let searchViewController = SearchAssembler.assembly()
		let favoritesViewController = FavoritesAssembler.assembly()
		
		let mainTabBarController = MainTabBarController(
			searchViewController: searchViewController,
			favoritesViewController: favoritesViewController
		)
		
		return mainTabBarController
	}
}
