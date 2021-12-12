import 'package:dio/dio.dart';
import 'package:fineance/data/network/api_error/api_error.dart';
import 'package:fineance/networking/api_client.dart';
import 'package:fineance/repositories/storage_repository.dart';
import 'package:fineance/repositories/user.dart';
import 'package:fineance/repositories/userwallet.dart';
import 'package:fineance/repositories/wallet.dart';

import 'goal.dart';


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

      final response = await _apiClient.wallets(_storageService.getBearerToken(),user);
      if(response!=null){
        wallets=response;
        return true;
      }
    } on DioError catch (error) {
      if(error.response?.data!=null){
        return false;
      }
    }
    return false;
  }


  Future<bool> downloadSubWallets() async {
    try {
      final username = _storageService.getUserName();

      User user = User(username: username, password: "", email: "");

      final response = await _apiClient.sub_wallets(_storageService.getBearerToken(),user);
      if(response!=null){
        subWallets=response;
        return true;
      }
    } on DioError catch (error) {
      if(error.response?.data!=null){
        return false;
      }
    }
    return false;
  }

  Future<bool> addGoal(Wallet wallet, Goal goal) async {
    try {

      GoalWallet goalWallet = GoalWallet(goal: goal, wallet: wallet);

      final response = await _apiClient.add_goal(_storageService.getBearerToken(),goalWallet);

      if(response!=null){
        return true;
      }

    } on DioError catch (error) {
      if(error.response?.data!=null){
        return false;
      }
    }
    return false;
  }

  Future<bool> addSubOwner(Wallet wallet, User user) async {
    try {

      UserWallet userWallet = UserWallet(wallet: wallet, user: user);

      final response = await _apiClient.add_sub_owner(_storageService.getBearerToken(),userWallet);

      if(response!=null){
        return true;
      }

    } on DioError catch (error) {
      if(error.response?.data!=null){
        return false;
      }
    }
    return false;
  }

  Future<bool> removeGoal(Wallet wallet, Goal goal) async {
    try {

      GoalWallet goalWallet = GoalWallet(goal: goal, wallet: wallet);

      final response = await _apiClient.remove_goal(_storageService.getBearerToken(),goalWallet);

      if(response!=null){
        return true;
      }

    } on DioError catch (error) {
      if(error.response?.data!=null){
        throw ApiError.fromJson(error.response?.data as Map<String, dynamic>);
      }
    }
    return false;
  }


  Future<bool> removeSubOwner(Wallet wallet, User user) async {
    try {

      UserWallet userWallet = UserWallet(wallet: wallet, user: user);

      final response = await _apiClient.remove_sub_owner(_storageService.getBearerToken(),userWallet);

      if(response!=null){
        return true;
      }

    } on DioError catch (error) {
      if(error.response?.data!=null){
        return false;
      }
    }
    return false;
  }


  Future<bool> updateWallet(Wallet wallet) async {
    try {
      final response = await _apiClient.update_wallet(_storageService.getBearerToken(),wallet);

      if(response!=null){
        return true;
      }

    } on DioError catch (error) {
      if(error.response?.data!=null){
        return false;
      }
    }
    return false;
  }

  Future<bool> addRemitance(Wallet wallet, Remittance remittance) async {
    try {
      RemittanceWallet userWallet = RemittanceWallet(wallet: wallet, remittance: remittance);

      final response = await _apiClient.add_remittance(_storageService.getBearerToken(),userWallet);

      if(response!=null){
        return true;
      }

    } on DioError catch (error) {
      if(error.response?.data!=null){
        return false;
      }
    }
    return false;
  }

  Future<bool> addWallet(Wallet wallet) async {
    try {
      final response = await _apiClient.remove_wallet(_storageService.getBearerToken(), wallet);

      if(response!=null){
        return true;
      }

    } on DioError catch (error) {
      if(error.response?.data!=null){
        return false;
      }
    }
    return false;
  }

  Future<bool> removeWallet(Wallet wallet) async {
    try {
      final response = await _apiClient.add_wallet(_storageService.getBearerToken(), wallet);

      if(response!=null){
        return true;
      }

    } on DioError catch (error) {
      if(error.response?.data!=null){
        return false;
      }
    }
    return false;
  }


}