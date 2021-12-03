import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_core/app_core.dart';

@lazySingleton
class CountStorage extends Storage<int> {
  CountStorage({
    required SharedPreferences prefs,
  }) : super(
          prefs: prefs,
          key: 'count',
        );

  @override
  int? get({int? defaultValue}) {
    return prefs.getInt(key);
  }

  @override
  void set(int value) {
    prefs.setInt(key, value);
  }
}
