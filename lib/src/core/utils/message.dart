import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';
import '../localization/keys.g.dart';

class Message extends Equatable {
  final String value;
  final int? code;
  final String? platformCode;
  final bool readable;

  const Message(
    this.value, {
    this.code,
    this.platformCode,
    this.readable = false,
  });

  factory Message.fromFailure(Failure failure) {
    if (failure is ServerFailure) {
      return Message(failure.message, code: failure.statusCode);
    } else if (failure is NetworkFailure) {
      return Message(LocaleKeys.error_messages_no_internet_connection,
          readable: true);
    }
    return Message(failure.message);
  }

  String getMessageFromCode() {
    switch (code!) {
      case -1:
        return LocaleKeys.error_messages_operation_failed_retry.tr();
      case 0:
        return LocaleKeys.error_messages_operation_cancelled.tr();
      case >= 200 && < 300:
        return LocaleKeys.error_messages_200s.tr();
      case 400:
        return LocaleKeys.error_messages_check_input_info.tr();
      case 401:
        return LocaleKeys.error_messages_401.tr();
      case 403:
        return LocaleKeys.error_messages_403.tr();
      case 404:
        return LocaleKeys.error_messages_404.tr();
      case 422:
        return LocaleKeys.error_messages_422.tr();
      case > 404 && < 500:
        return LocaleKeys.error_messages_check_input_retry.tr();
      case 500:
        return LocaleKeys.error_messages_internal_error_contact_support.tr();
      case 502:
        return LocaleKeys.error_messages_retry_later_contact_support.tr();
      default:
        return LocaleKeys.error_messages_unknown_error.tr();
    }
  }

  String getMessageFromPlatformCode() {
    switch (platformCode!) {
      case "1":
        return LocaleKeys.error_messages_operation_cancelled.tr();
      case "3":
        return LocaleKeys.error_messages_purchase_failed_error_3.tr();
      // case "6":
      //   return LocaleKeys.error_messages_already_subscribed_restore.tr();
      case "7":
        return LocaleKeys.error_messages_cannot_restore_subscription_error_7
            .tr();
      case "10":
        return LocaleKeys.error_messages_network_error_retry.tr();
      // case "15":
      //   return LocaleKeys.error_messages_subscription_pending_wait.tr();
      default:
        return LocaleKeys.error_messages_operation_failed_with_code_args
            .tr(args: [platformCode!]);
    }
  }

  String? tryParseMessage() {
    final message = value.toLowerCase();
    if (message.contains("failed host lookup")) {
      return LocaleKeys.error_messages_no_internet_connection.tr();
    } else if (message.contains("connection reset by peer") ||
        message.contains("operation timed out") ||
        message.contains("connection closed")) {
      return LocaleKeys.error_messages_internet_connection_error_retry.tr();
    } else if (message.contains("unexpected character")) {
      return LocaleKeys.error_messages_data_receiving_error_contact_support
          .tr();
    } else if (message.contains("handshake error")) {
      return LocaleKeys.error_messages_internet_connection_handshake_error.tr();
    } else if (message.contains("cancelled") || message.contains("canceled")) {
      return LocaleKeys.error_messages_operation_cancelled.tr();
    } else if (message.contains("statuscode: 400")) {
      return LocaleKeys.error_messages_cannot_complete_request.tr();
    } else if (message.contains("you don't have active subscriptions")) {
      return LocaleKeys.error_messages_no_active_subscriptions.tr();
    } else if (message.contains("canceled") || message.contains("cancelled")) {
      return LocaleKeys.error_messages_operation_cancelled.tr();
    }
    return null;
  }

  @override
  String toString() {
    if (readable) return value;
    if (code != null) return getMessageFromCode();
    if (platformCode != null) return getMessageFromPlatformCode();
    if (tryParseMessage() != null) return tryParseMessage()!;

    return LocaleKeys.error_messages_unknown.tr();
  }

  @override
  List<Object?> get props => [value, code, readable];
}
