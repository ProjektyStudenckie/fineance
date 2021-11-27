import 'package:json_annotation/json_annotation.dart';

part 'tokens_response.g.dart';

@JsonSerializable()
class TokensResponse {
  @JsonKey(name: "access_token")
  final String? accessToken;
  @JsonKey(name: "refresh_token")
  final String? refreshToken;

  TokensResponse({
    this.accessToken,
    this.refreshToken,
  });

  factory TokensResponse.fromJson(Map<String, dynamic> json) =>
      _$TokensResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokensResponseToJson(this);
}
