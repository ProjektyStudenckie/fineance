import 'dart:core';

import 'package:dio/dio.dart';
import 'package:fineance/data/network/api_error/api_error.dart';
import 'package:fineance/networking/api_client.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:fineance/repositories/storage_repository.dart';
import 'package:fineance/repositories/user.dart';
import 'package:fineance/repositories/userwallet.dart';
import 'package:fineance/repositories/wallet.dart';

import 'goal.dart';

class WalletRepository {
  List<Wallet> wallets = [];
  late List<Wallet> subWallets;
  final ApiClient _apiClient;
  final AuthenticationRepository authenticationRepository;
  final StorageService _storageService;

  int chosenWalletIndex = -1;

  WalletRepository(this.authenticationRepository, this._apiClient, this._storageService);

  Future<bool> downloadWallets() async {
    try {
      await authenticationRepository.refreshToken();

      final username = _storageService.getUserName();
      final User user = User(username: username, password: "", email: "");

      final response =
          await _apiClient.wallets(_storageService.getBearerToken(), user);
      if (response != null) {
        wallets = response;
        return true;
      }
      else{
        wallets.clear();
      }
    } on DioError catch (error) {
      wallets.clear();
      if (error.response?.data != null) {
        return false;
      }
    }
    return false;
  }

  Future<bool> downloadSubWallets() async {
    try {
      await authenticationRepository.refreshToken();

      final username = _storageService.getUserName();
      final User user = User(username: username, password: "", email: "");

      final response =
          await _apiClient.sub_wallets(_storageService.getBearerToken(), user);
      if (response != null) {
        subWallets = response;
        return true;
      }
    } on DioError catch (error) {
      if (error.response?.data != null) {
        return false;
      }
    }
    return false;
  }

  Future<bool> addGoal(Wallet wallet, Goal goal) async {
    try {
      await authenticationRepository.refreshToken();
      final GoalWallet goalWallet = GoalWallet(goal: goal, wallet: wallet);

      final response = await _apiClient.add_goal(
          _storageService.getBearerToken(), goalWallet);

      if (response != null) {
        return true;
      }
    } on DioError catch (error) {
      if (error.response?.data != null) {
        return false;
      }
    }
    return false;
  }

  Future<bool> addSubOwner(Wallet wallet, User user) async {
    try {
      await authenticationRepository.refreshToken();

      UserWallet userWallet = UserWallet(wallet: wallet, user: user);

      final response = await _apiClient.add_sub_owner(
          _storageService.getBearerToken(), userWallet);

      if (response != null) {
        return true;
      }
    } on DioError catch (error) {
      if (error.response?.data != null) {
        return false;
      }
    }
    return false;
  }

  Future<bool> removeGoal(Wallet wallet, Goal goal) async {
    try {
      await authenticationRepository.refreshToken();

      GoalWallet goalWallet = GoalWallet(goal: goal, wallet: wallet);

      final response = await _apiClient.remove_goal(
          _storageService.getBearerToken(), goalWallet);

      if (response != null) {
        return true;
      }
    } on DioError catch (error) {
      if (error.response?.data != null) {
        throw ApiError.fromJson(error.response?.data as Map<String, dynamic>);
      }
    }
    return false;
  }

  Future<bool> removeSubOwner(Wallet wallet, User user) async {
    try {
      await authenticationRepository.refreshToken();

      UserWallet userWallet = UserWallet(wallet: wallet, user: user);

      final response = await _apiClient.remove_sub_owner(
          _storageService.getBearerToken(), userWallet);

      if (response != null) {
        return true;
      }
    } on DioError catch (error) {
      if (error.response?.data != null) {
        return false;
      }
    }
    return false;
  }

  Future<bool> updateWallet(Wallet wallet) async {
    await authenticationRepository.refreshToken();
    try {
      final response = await _apiClient.update_wallet(
          _storageService.getBearerToken(), wallet);

      if (response != null) {
        return true;
      }
    } on DioError catch (error) {
      if (error.response?.data != null) {
        return false;
      }
    }
    return false;
  }

  Future<bool> addRemitance(Wallet wallet, Remittance remittance) async {
    await authenticationRepository.refreshToken();
    try {
      RemittanceWallet userWallet =
          RemittanceWallet(wallet: wallet, remittance: remittance);

      final response = await _apiClient.add_remittance(
          _storageService.getBearerToken(), userWallet);

      if (response != null) {
        return true;
      }
    } on DioError catch (error) {
      if (error.response?.data != null) {
        return false;
      }
    }
    return false;
  }

  Future<bool> addWallet(Wallet wallet) async {
    await authenticationRepository.refreshToken();
    try {
      final response =
          await _apiClient.add_wallet(_storageService.getBearerToken(), wallet);

      if (response != null) {
        return true;
      }
    } on DioError catch (error) {
      if (error.response?.data != null) {
        return false;
      }
    }
    return false;
  }

  Future<bool> removeWallet(Wallet wallet) async {
    await authenticationRepository.refreshToken();
    try {
      final response = await _apiClient.remove_wallet(
          _storageService.getBearerToken(), wallet);

      if (response != null) {
        return true;
      }
    } on DioError catch (error) {
      if (error.response?.data != null) {
        return false;
      }
    }
    return false;
  }
}
