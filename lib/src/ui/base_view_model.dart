import 'package:app_core/src/helpers/unit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:synchronized/synchronized.dart';

abstract class BaseViewModel {
  static final _callLock = Lock();

  void initState() {}

  void disposeState() {}

  dynamic _defaultFailure(dynamic error) => Fluttertoast.showToast(msg: error.toString());

  @protected
  Future<Unit> run(
    dynamic Function() handler, {
    bool showLoading = true,
    dynamic Function()? onSuccess,
    dynamic Function(dynamic error)? onFailure,
  }) async {
    return showLoading
        ? _callLock.synchronized<Unit>(() => _run(
              handler,
              showLoading: showLoading,
              onSuccess: onSuccess,
              onFailure: onFailure,
            ))
        : _run(
            handler,
            showLoading: showLoading,
            onSuccess: onSuccess,
            onFailure: onFailure,
          );
  }

  Future<Unit> _run(
    dynamic Function() handler, {
    bool showLoading = true,
    dynamic Function()? onSuccess,
    dynamic Function(dynamic error)? onFailure,
  }) async {
    var success = true;
    try {
      if (showLoading) {
        await EasyLoading.show(status: "Chờ xíu");
      }
      final result = handler();
      if (result is Future) {
        await result;
      }
    } catch (error) {
      success = false;
      final result = onFailure != null ? onFailure(error) : _defaultFailure(error);
      if (result is Future) {
        await result;
      }
    } finally {
      if (showLoading) {
        await EasyLoading.dismiss();
      }
      if (success) {
        final result = onSuccess?.call();
        if (result is Future) {
          await result;
        }
      }
    }
    return unit;
  }
}
