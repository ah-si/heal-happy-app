import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:heal_happy/common/l10n/error_localizations.dart';
import 'package:heal_happy/common/utils/constants.dart';

FutureOr<dynamic> handleCaughtError(error, stackTrace) {
  throw handleError(error, stackTrace);
}

ErrorResultException handleError(error, stackTrace) {
  if (error is ErrorResult) {
    return ErrorResultException(error);
  } else if (error is ErrorResultException) {
    return error;
  } else {
    var result = ErrorResultException(ErrorResult.internal);
    final isDioTimeout = (error is DioError &&
        (error.type == DioErrorType.connectTimeout || error.type == DioErrorType.receiveTimeout || error.type == DioErrorType.sendTimeout));
    if (error is TimeoutException || isDioTimeout) {
      result = ErrorResultException(ErrorResult.noNetwork);
    } else if (error is DioError && error.response?.statusCode == 401) {
      result = ErrorResultException(ErrorResult.notLogged);
    } else if (error is DioError && error.response?.statusCode == 403 && error.response!.data!.toString().contains('meeting_exist_already')) {
      result = ErrorResultException(ErrorResult.meetingAlreadyExist);
    } else if (error is DioError && error.response?.statusCode == 403 && error.response!.data!.toString().contains('account_not_activated')) {
      result = ErrorResultException(ErrorResult.accountNotActivated);
    } else if (error is DioError && error.response?.statusCode == 403 && error.response!.data!.toString().contains('account_not_verified')) {
      result = ErrorResultException(ErrorResult.accountNotVerified);
    } else if (error is DioError && error.response?.statusCode == 403 && error.response!.data!.toString().contains('no_past_event')) {
      result = ErrorResultException(ErrorResult.noPastEvent);
    } else if (error is DioError && error.response?.statusCode == 403 && error.response!.data!.toString().contains('no_past_opening')) {
      result = ErrorResultException(ErrorResult.noPastOpening);
    } else if (error is DioError && error.response?.statusCode == 403 && error.response!.data!.toString().contains('no_face_to_face_allowed')) {
      result = ErrorResultException(ErrorResult.faceToFaceNotAllowed);
    } else if (error is DioError && error.response?.statusCode == 403 && error.response!.data!.toString().contains('patient_slot_taken')) {
      result = ErrorResultException(ErrorResult.patientAlreadyBusy);
    } else if (error is DioError && error.response?.statusCode == 400 && error.response!.data!.toString().contains('opening_room_overlap')) {
      result = ErrorResultException(ErrorResult.noOpeningRoomOverlap);
    } else if (error is DioError && error.response?.statusCode == 400 && error.response!.data!.toString().contains('opening_overlap')) {
      result = ErrorResultException(ErrorResult.noOpeningOverlap);
    } else if (error is DioError && error.response?.statusCode == 400 && error.response!.data!.toString().contains('slot_taken')) {
      result = ErrorResultException(ErrorResult.meetingAlreadyBooked);
    } else if (error is DioError && error.response?.statusCode == 403) {
      result = ErrorResultException(ErrorResult.forbidden);
    } else if (error is DioError && error.response?.statusCode == 404 && error.response!.data!.toString().contains('no_healer')) {
      result = ErrorResultException(ErrorResult.noHealer);
    } else if (error is DioError && error.response?.statusCode == 404 && error.response!.data!.toString().contains('no_user')) {
      result = ErrorResultException(ErrorResult.noAccount);
    } else if (error is DioError && error.response?.statusCode == 404) {
      result = ErrorResultException(ErrorResult.notFound);
    } else if (error is DioError && error.response?.statusCode == 400 && error.response!.data.toString().contains('terms_required')) {
      result = ErrorResultException(ErrorResult.termsRequired);
    }
    kDebugLogger.severe('handleError: Future error from $error forwarded to $result', error, stackTrace);
    return result;
  }
}

class ErrorResultException implements Exception {
  final ErrorResult cause;

  ErrorResultException(this.cause);

  @override
  bool operator ==(Object other) => identical(this, other) || other is ErrorResultException && runtimeType == other.runtimeType && cause == other.cause;

  @override
  int get hashCode => cause.hashCode;

  @override
  String toString() {
    return 'ErrorResultException{cause: $cause}';
  }
}

class ErrorResult {
  static const noNetwork = ErrorResult(_ErrorType.noNetwork);
  static const wrongEmail = ErrorResult(_ErrorType.wrongEmail);
  static const emailAlreadyUsed = ErrorResult(_ErrorType.emailAlreadyUsed);
  static const notLogged = ErrorResult(_ErrorType.notLogged);
  static const forbidden = ErrorResult(_ErrorType.forbidden);
  static const termsRequired = ErrorResult(_ErrorType.termsRequired);
  static const adminTermsRequired = ErrorResult(_ErrorType.adminTermsRequired);
  static const wrongCredentials = ErrorResult(_ErrorType.wrongCredentials);
  static const linkExpired = ErrorResult(_ErrorType.linkExpired);
  static const noAccount = ErrorResult(_ErrorType.noAccount);
  static const noHealer = ErrorResult(_ErrorType.noHealer);
  static const notFound = ErrorResult(_ErrorType.notFound);
  static const fileTooBig = ErrorResult(_ErrorType.fileTooBig);
  static const noUser = ErrorResult(_ErrorType.noUser);
  static const faceToFaceNotAllowed = ErrorResult(_ErrorType.faceToFaceNotAllowed);

  // generic
  static const internal = ErrorResult(_ErrorType.internal);
  static const noAppForActionError = ErrorResult(_ErrorType.noAppForActionError);
  static const fieldRequired = ErrorResult(_ErrorType.fieldRequired);
  static const meetingAlreadyExist = ErrorResult(_ErrorType.meetingAlreadyExist);
  static const healerMeetingAlreadyExist = ErrorResult(_ErrorType.healerMeetingAlreadyExist);
  static const accountNotActivated = ErrorResult(_ErrorType.accountNotActivated);
  static const dateStartAfterEnd = ErrorResult(_ErrorType.dateStartAfterEnd);
  static const accountNotVerified = ErrorResult(_ErrorType.accountNotVerified);
  static const noPastEvent = ErrorResult(_ErrorType.noPastEvent);
  static const noPastOpening = ErrorResult(_ErrorType.noPastOpening);
  static const noOpeningOverlap = ErrorResult(_ErrorType.noOpeningOverlap);
  static const noOpeningRoomOverlap = ErrorResult(_ErrorType.noOpeningRoomOverlap);
  static const meetingAlreadyBooked = ErrorResult(_ErrorType.meetingAlreadyBooked);
  static const patientAlreadyBusy = ErrorResult(_ErrorType.patientAlreadyBusy);
  static const healerPatientAlreadyBusy = ErrorResult(_ErrorType.healerPatientAlreadyBusy);

  final _ErrorType _type;

  const ErrorResult(this._type);

  String getMessage(BuildContext context) {
    final localizations = ErrorLocalizations.of(context);
    switch (_type) {
      case _ErrorType.wrongEmail:
        return localizations.wrongEmailMessage;
      case _ErrorType.noNetwork:
        return localizations.noNetworkMessage;

      // generic
      case _ErrorType.internal:
        return localizations.internalMessage;
      case _ErrorType.noAppForActionError:
        return localizations.noAppForTheAction;
      case _ErrorType.fieldRequired:
        return localizations.fieldRequired;
      case _ErrorType.notLogged:
        return localizations.notLogged;
      case _ErrorType.forbidden:
        return localizations.forbidden;
      case _ErrorType.wrongCredentials:
        return localizations.wrongCredentials;
      case _ErrorType.meetingAlreadyExist:
        return localizations.meetingAlreadyExist;
      case _ErrorType.healerMeetingAlreadyExist:
        return localizations.healerMeetingAlreadyExist;
      case _ErrorType.emailAlreadyUsed:
        return localizations.emailAlreadyUsed;
      case _ErrorType.meetingAlreadyBooked:
        return localizations.meetingAlreadyBooked;
      case _ErrorType.noPastEvent:
        return localizations.noPastEvent;
      case _ErrorType.accountNotActivated:
        return localizations.accountNotActivated;
      case _ErrorType.linkExpired:
        return localizations.linkExpired;
      case _ErrorType.fileTooBig:
        return localizations.fileTooBig;
      case _ErrorType.termsRequired:
        return localizations.termsRequired;
      case _ErrorType.adminTermsRequired:
        return localizations.termsRequired;
      case _ErrorType.noUser:
        return localizations.noUser;
      case _ErrorType.accountNotVerified:
        return localizations.accountNotVerified;
      case _ErrorType.noPastOpening:
        return localizations.noPastOpening;
      case _ErrorType.noOpeningOverlap:
        return localizations.noOpeningOverlap;
      case _ErrorType.dateStartAfterEnd:
        return localizations.dateStartAfterEnd;
      case _ErrorType.faceToFaceNotAllowed:
        return localizations.faceToFaceNotAllowed;
      case _ErrorType.patientAlreadyBusy:
        return localizations.patientAlreadyBusy;
      case _ErrorType.healerPatientAlreadyBusy:
        return localizations.healerPatientAlreadyBusy;
      case _ErrorType.noAccount:
        return localizations.noAccount;
      case _ErrorType.notFound:
        return localizations.notFound;
      case _ErrorType.noHealer:
        return localizations.noHealer;
      case _ErrorType.noOpeningRoomOverlap:
        return localizations.noOpeningRoomOverlap;
    }
  }

  String twoLiner(BuildContext context) {
    return '${getMessage(context)}\n${getHint(context)}';
  }

  String getHint(BuildContext context) {
    final localizations = ErrorLocalizations.of(context);
    switch (_type) {
      case _ErrorType.wrongEmail:
        return '';
      case _ErrorType.noNetwork:
        return localizations.noNetworkHint;
      // generic
      case _ErrorType.internal:
        return localizations.internalHint;
      case _ErrorType.noAppForActionError:
        return localizations.noAppForTheActionHint;
      case _ErrorType.fieldRequired:
        return localizations.fieldRequiredHint;
      case _ErrorType.notLogged:
        return localizations.notLoggedHint;
      case _ErrorType.forbidden:
        return localizations.forbiddenHint;
      case _ErrorType.wrongCredentials:
        return localizations.wrongCredentialsHint;
      case _ErrorType.meetingAlreadyExist:
        return localizations.meetingAlreadyExistHint;
      case _ErrorType.healerMeetingAlreadyExist:
        return localizations.healerMeetingAlreadyExistHint;
      case _ErrorType.emailAlreadyUsed:
        return localizations.emailAlreadyUsedHint;
      case _ErrorType.meetingAlreadyBooked:
        return localizations.meetingAlreadyBookedHint;
      case _ErrorType.noPastEvent:
        return localizations.noPastEventHint;
      case _ErrorType.accountNotActivated:
        return localizations.accountNotActivatedHint;
      case _ErrorType.linkExpired:
        return localizations.linkExpiredHint;
      case _ErrorType.fileTooBig:
        return localizations.fileTooBigHint;
      case _ErrorType.termsRequired:
        return localizations.termsRequiredHint;
      case _ErrorType.adminTermsRequired:
        return localizations.adminTermsRequiredHint;
      case _ErrorType.noUser:
        return localizations.noUserHint;
      case _ErrorType.accountNotVerified:
        return localizations.accountNotVerifiedHint;
      case _ErrorType.noPastOpening:
        return localizations.noPastOpeningHint;
      case _ErrorType.noOpeningOverlap:
        return localizations.noOpeningOverlapHint;
      case _ErrorType.dateStartAfterEnd:
        return localizations.dateStartAfterEndHint;
      case _ErrorType.faceToFaceNotAllowed:
        return localizations.faceToFaceNotAllowedHint;
      case _ErrorType.patientAlreadyBusy:
        return localizations.patientAlreadyBusyHint;
      case _ErrorType.healerPatientAlreadyBusy:
        return localizations.healerPatientAlreadyBusyHint;
      case _ErrorType.noAccount:
        return localizations.noAccountHint;
      case _ErrorType.notFound:
        return localizations.notFoundHint;
      case _ErrorType.noHealer:
        return localizations.noHealerHint;
      case _ErrorType.noOpeningRoomOverlap:
        return localizations.noOpeningRoomOverlapHint;
    }
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is ErrorResult && runtimeType == other.runtimeType && _type == other._type;

  @override
  int get hashCode => _type.hashCode;

  @override
  String toString() {
    return 'ErrorResult{$_type}';
  }
}

enum _ErrorType {
  noNetwork,
  notLogged,
  forbidden,
  termsRequired,
  adminTermsRequired,
  wrongCredentials,
  linkExpired,
  noAccount,
  noHealer,
  notFound,
  fileTooBig,
  noUser,
  faceToFaceNotAllowed,
  internal,
  wrongEmail,
  emailAlreadyUsed,
  fieldRequired,
  meetingAlreadyExist,
  healerMeetingAlreadyExist,
  noPastEvent,
  noPastOpening,
  noOpeningOverlap,
  noOpeningRoomOverlap,
  accountNotActivated,
  dateStartAfterEnd,
  accountNotVerified,
  meetingAlreadyBooked,
  patientAlreadyBusy,
  healerPatientAlreadyBusy,
  noAppForActionError,
}
