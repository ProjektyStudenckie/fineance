import 'package:dio/dio.dart';
import 'package:fineance/data/network/api_error/api_error.dart';
import 'package:fineance/networking/api_client.dart';
import 'package:fineance/repositories/storage_repository.dart';
import 'package:fineance/repositories/user.dart';
import 'package:fineance/repositories/wallet.dart';


class WalletRepository{

  late List<Wallet> wallets;
  late List<Wallet> subWallets;
  final ApiClient _apiClient;
  final StorageService _storageService;

  WalletRepository(
      this._apiClient, this._storageService);

  Future<bool> downloadWallets() async {
    try {
      final username = _storageService.getUserName();

      User user = User(username: username, password: "", email: "");

      final response = await _apiClient.wallets(user);
      if(response!=null){
        wallets=response;
        return true;
      }
    } on DioError catch (error) {
      throw ApiError.fromJson(error.response?.data as Map<String, dynamic>);
    }
    return false;
  }


  Future<bool> downloadSubWallets() async {
    try {
      final username = _storageService.getUserName();

      User user = User(username: username, password: "", email: "");

      final response = await _apiClient.sub_wallets(user);
      if(response!=null){
        subWallets=response;
        return true;
      }
    } on DioError catch (error) {
      throw ApiError.fromJson(error.response?.data as Map<String, dynamic>);
    }
    return false;
  }



}