// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokensResponse _$TokensResponseFromJson(Map<String, dynamic> json) =>
    TokensResponse(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$TokensResponseToJson(TokensResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
