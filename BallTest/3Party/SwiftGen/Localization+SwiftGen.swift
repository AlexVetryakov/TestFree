// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Cancel
  internal static let alertButtonCancelTitle = L10n.tr("Localizable", "alert_button_cancel_title")
  /// OK
  internal static let alertButtonOkTitle = L10n.tr("Localizable", "alert_button_ok_title")
  /// Warning
  internal static let alertCommonTitle = L10n.tr("Localizable", "alert_common_title")
  /// Be happy
  internal static let firstAnswer = L10n.tr("Localizable", "first_answer")
  /// You can add default answers on Settings Screen
  internal static let mainAlertAnswerMessage = L10n.tr("Localizable", "main_alert_answer_message")
  /// Enter your question, please
  internal static let mainAlertQuestionMessage = L10n.tr("Localizable", "main_alert_question_message")
  /// Shakes count = %@
  internal static func mainEventsCount(_ p1: String) -> String {
    return L10n.tr("Localizable", "main_events_count", p1)
  }
  /// question
  internal static let mainQuestionPlaceholder = L10n.tr("Localizable", "main_question_placeholder")
  /// Write your question and shake the device to get answer
  internal static let mainQuestionTitle = L10n.tr("Localizable", "main_question_title")
  /// Main
  internal static let mainTitle = L10n.tr("Localizable", "main_title")
  /// Try again
  internal static let secondAnswer = L10n.tr("Localizable", "second_answer")
  /// New default answer
  internal static let settingsAlertEventMessage = L10n.tr("Localizable", "settings_alert_event_message")
  /// Be sure that you entered correct answer
  internal static let settingsAlertMessage = L10n.tr("Localizable", "settings_alert_message")
  /// Settings
  internal static let settingsTitle = L10n.tr("Localizable", "settings_title")
  /// Go home
  internal static let thirdAnswer = L10n.tr("Localizable", "third_answer")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
