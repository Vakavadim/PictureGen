// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum FavoritesScene {
    /// Delete
    internal static let delete = L10n.tr("Localizable", "FavoritesScene.delete")
    /// Favorites
    internal static let title = L10n.tr("Localizable", "FavoritesScene.title")
  }

  internal enum SearchScene {
    /// Error
    internal static let error = L10n.tr("Localizable", "SearchScene.error")
    /// Start typing text to generate an image.
    internal static let info = L10n.tr("Localizable", "SearchScene.info")
    /// Save
    internal static let saveButtonTitle = L10n.tr("Localizable", "SearchScene.saveButtonTitle")
    /// The picture has been saved with seatch term: 
    internal static let saveMessage = L10n.tr("Localizable", "SearchScene.saveMessage")
    /// Search
    internal static let title = L10n.tr("Localizable", "SearchScene.title")

    internal enum ErrorMessage {
      /// Data not found
      internal static let dataNotFound = L10n.tr("Localizable", "SearchScene.errorMessage.dataNotFound")
      /// Invalid Url
      internal static let invalidUrl = L10n.tr("Localizable", "SearchScene.errorMessage.invalidUrl")
      /// No internet connection
      internal static let noInternetConnection = L10n.tr("Localizable", "SearchScene.errorMessage.noInternetConnection")
    }
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