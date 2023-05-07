// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum FavoritesScene {
    /// Favorites
    internal static let title = L10n.tr("Localizable", "FavoritesScene.title")
  }

  internal enum SearchScene {
    /// Search
    internal static let title = L10n.tr("Localizable", "SearchScene.title")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all