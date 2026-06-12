// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Search {
    /// Due to API specifications, search is only available using English titles. Thank you for your understanding.
    internal static let description = L10n.tr("Localizable", "search.description", fallback: "Due to API specifications, search is only available using English titles. Thank you for your understanding.")
    /// Search by game title
    internal static let placeholder = L10n.tr("Localizable", "search.placeholder", fallback: "Search by game title")
  }
  internal enum SearchDetail {
    internal enum Favorite {
      /// Favorited
      internal static let alreadyDid = L10n.tr("Localizable", "search_detail.favorite.already_did", fallback: "Favorited")
      /// Favorite
      internal static let title = L10n.tr("Localizable", "search_detail.favorite.title", fallback: "Favorite")
    }
  }
  internal enum StoreDeal {
    /// Deals On Store highlights deals with a Metacritic score of 80 or higher and a discount of 30%% or more from each store.
    /// 
    /// For other deals, please search by game title on the Search screen.
    internal static let description = L10n.tr("Localizable", "storeDeal.description", fallback: "Deals On Store highlights deals with a Metacritic score of 80 or higher and a discount of 30%% or more from each store.\n\nFor other deals, please search by game title on the Search screen.")
    /// See More
    internal static let seeMore = L10n.tr("Localizable", "storeDeal.seeMore", fallback: "See More")
    /// Deal's On Store
    internal static let title = L10n.tr("Localizable", "storeDeal.title", fallback: "Deal's On Store")
  }
  internal enum Tab {
    internal enum Favorites {
      /// star
      internal static let sficon = L10n.tr("Localizable", "tab.favorites.sficon", fallback: "star")
      /// Favorites
      internal static let title = L10n.tr("Localizable", "tab.favorites.title", fallback: "Favorites")
    }
    internal enum Home {
      /// house
      internal static let sficon = L10n.tr("Localizable", "tab.home.sficon", fallback: "house")
      /// Home
      internal static let title = L10n.tr("Localizable", "tab.home.title", fallback: "Home")
    }
    internal enum Search {
      /// magnifyingglass
      internal static let sficon = L10n.tr("Localizable", "tab.search.sficon", fallback: "magnifyingglass")
      /// Search
      internal static let title = L10n.tr("Localizable", "tab.search.title", fallback: "Search")
    }
  }
  internal enum TodaysDeal {
    /// Today's Deal highlights deals with a Metacritic score of 80 or higher and a discount of 50%% or more from all available deals.
    /// 
    /// For other deals, please search by game title on the Search screen.
    internal static let description = L10n.tr("Localizable", "todaysDeal.description", fallback: "Today's Deal highlights deals with a Metacritic score of 80 or higher and a discount of 50%% or more from all available deals.\n\nFor other deals, please search by game title on the Search screen.")
    /// Today's Deal
    internal static let title = L10n.tr("Localizable", "todaysDeal.title", fallback: "Today's Deal")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
