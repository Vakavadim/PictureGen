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
		let fileLimit: UInt8 = 12
		let CDStorageManager = CDStorageManager()
		let CDstorageManagerWithLimit = CDStorageManagerWithFileLimit(storageManager: CDStorageManager, fileLimit: fileLimit)
		let searchViewController = SearchAssembler.assembly(storageManager: CDstorageManagerWithLimit)
		let favoritesViewController = FavoritesAssembler.assembly(storageManager: CDstorageManagerWithLimit)
		
		let mainTabBarController = MainTabBarController(
			searchViewController: searchViewController,
			favoritesViewController: favoritesViewController
		)

		mainTabBarController.tabBar.isTranslucent = false
		mainTabBarController.tabBar.backgroundColor = .white
		
		return mainTabBarController
	}
}
