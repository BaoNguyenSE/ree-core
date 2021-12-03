import 'package:dio/dio.dart';
import 'package:example/injector.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:app_core/app_core.dart';

part 'account_service.g.dart';

@lazySingleton
@RestApi(baseUrl: "http://dev.sugamobile.com:26124")
abstract class AccountService {
  @factoryMethod
  factory AccountService() => _AccountService(injector<HttpClientWrapper>().dio);

  @POST("/otp/mail")
  Future<bool> sendOtp(@Body() Map<String, dynamic> map);
}
