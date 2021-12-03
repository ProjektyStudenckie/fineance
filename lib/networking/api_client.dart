import 'package:dio/dio.dart';
import 'package:fineance/data/network/authorization/login_response/login_response.dart';
import 'package:fineance/data/network/authorization/tokens_response/tokens_response.dart';
import 'package:fineance/repositories/user.dart';
import 'package:fineance/repositories/userwallet.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

// How to connect to localhost:

// Android emulator - use baseUrl: http://10.0.2.2:1332

// iOS emulator - use baseUrl: http://127.0.0.1:1332
// and add this to info.plist: ???
// <key>NSAppTransportSecurity</key>
// <dict>
// 	<key>NSAllowsArbitraryLoads</key>
// 	<true/>
// </dict>

@RestApi(baseUrl: "http://192.168.0.66:1332")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(receiveTimeout: 30000, connectTimeout: 30000);
    dio.options.responseType = ResponseType.json;
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET("/login")
  Future<LoginResponse> login(@Header("Authorization") String auth);

  @POST("/register")
  Future<LoginResponse> registration(@Body() User auth);

  @GET("/refresh_access")
  Future<TokensResponse> refreshTokens(@Header("Token") String refreshToken);

  @GET("/sub_wallets")
  Future<List<Wallet>> sub_wallets(@Body() User auth);

  @GET("/wallets")
  Future<List<Wallet>> wallets(@Body() User auth);

  @POST("/add_wallet")
  Future<bool> add_wallet(@Body() Wallet wallet);

  @POST("/add_sub_owner")
  Future<bool> add_sub_owner(@Body() UserWallet userWallet);

  @POST("/remove_sub_owner")
  Future<bool> remove_sub_owner(@Body() UserWallet userWallet);

}
