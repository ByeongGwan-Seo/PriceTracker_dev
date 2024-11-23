// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// https://www.cheapshark.com/api/1.0
  internal static let apiBaseURL = L10n.tr("Localizable", "api_base_URL", fallback: "https://www.cheapshark.com/api/1.0")
  /// Ceapest Ever: $%@
  internal static func cheapestEverText(_ p1: Any) -> String {
    return L10n.tr("Localizable", "cheapest_ever_text", String(describing: p1), fallback: "Ceapest Ever: $%@")
  }
  /// Price: $%@
  internal static func dealPriceText(_ p1: Any) -> String {
    return L10n.tr("Localizable", "deal_price_text", String(describing: p1), fallback: "Price: $%@")
  }
  /// 詳細情報ロード中エラーが発生しました。もう一度やり直してください
  /// %@
  internal static func detailError(_ p1: Any) -> String {
    return L10n.tr("Localizable", "detail_error", String(describing: p1), fallback: "詳細情報ロード中エラーが発生しました。もう一度やり直してください\n%@")
  }
  /// Error
  internal static let errorTitle = L10n.tr("Localizable", "error_title", fallback: "Error")
  /// 表示する内容がありません
  internal static let noContentsError = L10n.tr("Localizable", "no_contents_error", fallback: "表示する内容がありません")
  /// N/A
  internal static let noInformationError = L10n.tr("Localizable", "no_information_error", fallback: "N/A")
  /// /games
  internal static let pathGames = L10n.tr("Localizable", "path_games", fallback: "/games")
  /// id
  internal static let queryId = L10n.tr("Localizable", "query_id", fallback: "id")
  /// title
  internal static let queryTitle = L10n.tr("Localizable", "query_title", fallback: "title")
  /// https://www.cheapshark.com/redirect?dealID=%@
  internal static func redirectStore(_ p1: Any) -> String {
    return L10n.tr("Localizable", "redirect_store", String(describing: p1), fallback: "https://www.cheapshark.com/redirect?dealID=%@")
  }
  /// Retail Price: $%@
  internal static func retailPriceText(_ p1: Any) -> String {
    return L10n.tr("Localizable", "retail_price_text", String(describing: p1), fallback: "Retail Price: $%@")
  }
  /// Savings: Less than 1%
  internal static let savingsNoneText = L10n.tr("Localizable", "savings_none_text", fallback: "Savings: Less than 1%")
  /// Savings: %@%%
  internal static func savingsRateText(_ p1: Any) -> String {
    return L10n.tr("Localizable", "savings_rate_text", String(describing: p1), fallback: "Savings: %@%%")
  }
  /// 検索中エラーが発生しました。もう一度検索してください
  /// %@
  internal static func searchError(_ p1: Any) -> String {
    return L10n.tr("Localizable", "search_error", String(describing: p1), fallback: "検索中エラーが発生しました。もう一度検索してください\n%@")
  }
  /// ゲーム名を入力してください
  internal static let searchPlaceholder = L10n.tr("Localizable", "search_placeholder", fallback: "ゲーム名を入力してください")
  /// OK
  internal static let uiOk = L10n.tr("Localizable", "ui_ok", fallback: "OK")
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
