// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum Localizable {
  /// Background Color
  internal static let backgroundColor = Localizable.tr("Localizable", "Background Color")
  /// Date Format
  internal static let dateFormat = Localizable.tr("Localizable", "Date Format")
  /// Watch Face
  internal static let watchFace = Localizable.tr("Localizable", "Watch Face")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension Localizable {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
