// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String?,
  name: json['name'] as String?,
  age: (json['age'] as num?)?.toInt(),
  address: json['address'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  isPremium: json['isPremium'] as bool?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'age': instance.age,
  'address': instance.address,
  'avatarUrl': instance.avatarUrl,
  'isPremium': instance.isPremium,
};
