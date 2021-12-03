import 'package:app_core/src/storage/storage.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OAuth2CredentialsStorage extends Storage<Credentials> {
  OAuth2CredentialsStorage({
    required SharedPreferences prefs,
    String key = 'oauth2_credentials',
  }) : super(prefs: prefs, key: key);

  @override
  Credentials? get({Credentials? defaultValue}) {
    final json = prefs.getString(key);
    return json != null ? Credentials.fromJson(json) : defaultValue;
  }

  @override
  void set(Credentials value) {
    prefs.setString(key, value.toJson());
  }
}
