import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Storage<T> {
  @protected
  final SharedPreferences prefs;

  @protected
  final String key;

  Storage({
    required this.prefs,
    required this.key,
  });

  T? get({T defaultValue});

  void set(T value);

  void remove() {
    prefs.remove(key);
  }
}
