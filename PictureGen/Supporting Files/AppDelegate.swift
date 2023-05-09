import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {

		// Create the window
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.backgroundColor = .white

		// Create the root view controller
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

		// Set the root view controller
		window?.rootViewController = mainTabBarController

		// Make the window visible
		window?.makeKeyAndVisible()

		return true
	}
}
