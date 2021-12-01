import 'package:fineance/injection/modules.dart';
import 'package:hive/hive.dart';

abstract class StorageService {
  String getBearerToken();

  String getRefreshToken();

  void saveTokens(String accessToken, String refreshToken);

  Future<int> clearTokens();
}

class StorageServiceImpl implements StorageService {
  final Box _tokensBox;

  StorageServiceImpl(this._tokensBox);

  @override
  String getBearerToken() {
    final token = _tokensBox.get(ACCESS_TOKEN) as String?;
    if (token?.isNotEmpty == true) {
      return "Bearer $token";
    }

    return "";
  }

  @override
  String getRefreshToken() {
    final token = _tokensBox.get(REFRESH_TOKEN) as String?;
    return token ?? "";
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _tokensBox.put(ACCESS_TOKEN, accessToken);
    await _tokensBox.put(REFRESH_TOKEN, refreshToken);
  }

  @override
  Future<int> clearTokens() async {
    return _tokensBox.clear();
  }
}
