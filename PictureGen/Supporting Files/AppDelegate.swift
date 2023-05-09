import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.backgroundColor = .white

		window?.rootViewController = assembly()

		window?.makeKeyAndVisible()

		return true
	}
	
	func assembly() -> UITabBarController {
		let fileLimit: UInt8 = 12
		let CDStorageManager = CDStorageManager()
		let CDstorageManagerWithLimit = CDStorageManagerWithFileLimit(storageManager: CDStorageManager, fileLimit: fileLimit)
		let searchViewController = SearchAssembler.assembly(storageManager: CDstorageManagerWithLimit)
		let favoritesViewController = FavoritesAssembler.assembly(storageManager: CDstorageManagerWithLimit)

		let mainTabBarController = MainTabBarController(
			searchViewController: searchViewController,
			favoritesViewController: favoritesViewController
		)

		mainTabBarController.tabBar.backgroundColor = Theme.backgroundColor
		UITabBar.appearance().isTranslucent = true

		return mainTabBarController
	}
}
