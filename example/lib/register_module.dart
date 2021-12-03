import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_core/app_core.dart';

@module
abstract class RegisterModule {
  @singleton
  @preResolve
  Future<SharedPreferences> getSharePreferences() async => SharedPreferences.getInstance();

  @singleton
  HttpClientWrapper getHttpClientWrapper(Oauth2Manager oauth2Manager) {
    return HttpClientWrapper(
      options: BaseOptions(
        baseUrl: "http://dev.sugamobile.com:26124",
        connectTimeout: 30000,
        receiveTimeout: 30000,
      ),
      logger: Logger(
        level: Level.debug,
        printer: SimplePrinter(),
      ),
      oauth2Manager: oauth2Manager,
      verbose: true,
    );
  }

  @singleton
  Oauth2Manager getOauth2Manager(SharedPreferences prefs) {
    return Oauth2Manager(
      endpoint: Uri.parse("http://dev.sugamobile.com:26124/oauth/token"),
      secret: "FqJfCb0CmPUv4OMeE8lTIoTE0SfDqJ8V5kpnREQM",
      identifier: "2",
      grantOwnerPassword: (Uri endpoint, String identifier, String secret, bool basicAuth, String username, String password, Iterable<String>? scopes) =>
          resourceOwnerPasswordGrant(endpoint, username, password, identifier: identifier, secret: secret, basicAuth: basicAuth),
      credentialStorage: OAuth2CredentialsStorage(prefs: prefs),
      logger: Logger(
        level: Level.debug,
        printer: SimplePrinter(),
      ),
    );
  }
}
