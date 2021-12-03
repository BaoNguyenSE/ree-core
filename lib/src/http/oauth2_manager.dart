import 'package:app_core/src/storage/storage.dart';
import 'package:logger/logger.dart';
import 'package:oauth2/oauth2.dart';
import 'package:synchronized/extension.dart';

class Oauth2Manager {
  final Uri endpoint;
  final String identifier;
  final String secret;
  final bool basicAuth;

  final Future<Client> Function(
    Uri endpoint,
    String identifier,
    String secret,
    bool basicAuth,
    String username,
    String password,
    Iterable<String>? scopes,
  ) grantOwnerPassword;

  final Storage<Credentials> credentialStorage;
  final Logger? logger;

  Oauth2Manager({
    required this.endpoint,
    required this.identifier,
    required this.secret,
    this.basicAuth = false,
    required this.grantOwnerPassword,
    required this.credentialStorage,
    this.logger,
  });

  Future<Credentials> login({
    required String username,
    required String password,
    Iterable<String>? scopes,
  }) async {
    logger?.d("Logging in - username $username, password $password");
    final client = await grantOwnerPassword(endpoint, identifier, secret, basicAuth, username, password, scopes);
    final Credentials credentials = client.credentials;
    credentialStorage.set(credentials);
    logger?.d("Logged in - credentials ${credentials.toJson()}");
    return credentials;
  }

  Future<Credentials> refresh({Credentials? credentials}) async {
    credentials ??= credentialStorage.get();

    logger?.d("Refreshing - credentials ${credentials?.toJson()}");

    if (credentials == null) {
      throw StateError("Credentials must be not null");
    }

    final newCredentials = await credentials.refresh(
      identifier: identifier,
      secret: secret,
      basicAuth: this.basicAuth,
    );
    credentialStorage.set(newCredentials);

    logger?.d("Refreshed - credentials ${newCredentials.toJson()}");
    return newCredentials;
  }

  Future<bool> isLoggedIn() async {
    final credentials = credentialStorage.get();
    return credentials != null && !credentials.isExpired;
  }

  Future<String?> getAccessToken({
    bool refreshIfExpired = true,
  }) async {
    var credentials = credentialStorage.get();

    if (credentials == null) {
      return null;
    }

    if (refreshIfExpired && credentials.isExpired) {
      await synchronized(() async {
        if (credentials != null && credentials!.isExpired) {
          credentials = await refresh(credentials: credentials);
        }
      });
    }

    return credentials?.accessToken;
  }
}
