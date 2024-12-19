// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add Tracking
  internal static let addTrackingString = L10n.tr("Localizable", "add_tracking_string", fallback: "Add Tracking")
  /// Tracking Now
  internal static let alreadyTrackingString = L10n.tr("Localizable", "already_tracking_string", fallback: "Tracking Now")
  /// https://www.cheapshark.com/api/1.0
  internal static let baseURL = L10n.tr("Localizable", "base_URL", fallback: "https://www.cheapshark.com/api/1.0")
  /// Cancel
  internal static let cancelButton = L10n.tr("Localizable", "cancel_button", fallback: "Cancel")
  /// Cheapest Ever: $%@
  internal static func cheapestEverString(_ p1: Any) -> String {
    return L10n.tr("Localizable", "cheapest_ever_string", String(describing: p1), fallback: "Cheapest Ever: $%@")
  }
  /// An error occurred while loading detailed information. Please try again. 
  /// %@
  internal static func detailErrorMessage(_ p1: Any) -> String {
    return L10n.tr("Localizable", "detail_error_message", String(describing: p1), fallback: "An error occurred while loading detailed information. Please try again. \n%@")
  }
  /// Localizable.strings
  ///   PriceTracker
  /// 
  ///   Created by seobyeonggwan on 2024/11/28.
  internal static let errorAlertTitle = L10n.tr("Localizable", "error_alert_title", fallback: "Error")
  /// /games
  internal static let gamesPath = L10n.tr("Localizable", "games_path", fallback: "/games")
  /// No Contents
  internal static let noContentString = L10n.tr("Localizable", "no_content_string", fallback: "No Contents")
  /// OK
  internal static let okButton = L10n.tr("Localizable", "ok_button", fallback: "OK")
  /// Enter Your Target Price
  internal static let priceInputPlaceholderString = L10n.tr("Localizable", "price_input_placeholder_string", fallback: "Enter Your Target Price")
  /// Enter Price
  internal static let priceInputString = L10n.tr("Localizable", "price_input_string", fallback: "Enter Price")
  /// Price: $%@
  internal static func priceString(_ p1: Any) -> String {
    return L10n.tr("Localizable", "price_string", String(describing: p1), fallback: "Price: $%@")
  }
  /// id
  internal static let queryGameId = L10n.tr("Localizable", "query_game_id", fallback: "id")
  /// title
  internal static let queryGameTitle = L10n.tr("Localizable", "query_game_title", fallback: "title")
  /// https://www.cheapshark.com/redirect?dealID=%@
  internal static func redirectToDeal(_ p1: Any) -> String {
    return L10n.tr("Localizable", "redirect_to_deal", String(describing: p1), fallback: "https://www.cheapshark.com/redirect?dealID=%@")
  }
  /// Retail Price: $%@
  internal static func retailPriceString(_ p1: Any) -> String {
    return L10n.tr("Localizable", "retail_price_string", String(describing: p1), fallback: "Retail Price: $%@")
  }
  /// Savings: None
  internal static let savingsNoneString = L10n.tr("Localizable", "savings_none_string", fallback: "Savings: None")
  /// Savings: %@%%
  internal static func savingsString(_ p1: Any) -> String {
    return L10n.tr("Localizable", "savings_string", String(describing: p1), fallback: "Savings: %@%%")
  }
  /// An error occurred while searching. Please try again. 
  /// %@
  internal static func searchErrorMessage(_ p1: Any) -> String {
    return L10n.tr("Localizable", "search_error_message", String(describing: p1), fallback: "An error occurred while searching. Please try again. \n%@")
  }
  /// Enter Game Title
  internal static let searchPlaceholder = L10n.tr("Localizable", "search_placeholder", fallback: "Enter Game Title")
  /// trackingInfos
  internal static let trackingInfoString = L10n.tr("Localizable", "tracking_info_string", fallback: "trackingInfos")
  /// Tracking Information
  internal static let trackingviewTitleString = L10n.tr("Localizable", "trackingview_title_string", fallback: "Tracking Information")
  /// User Price: $%@
  internal static func userPriceString(_ p1: Any) -> String {
    return L10n.tr("Localizable", "user_price_string", String(describing: p1), fallback: "User Price: $%@")
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
