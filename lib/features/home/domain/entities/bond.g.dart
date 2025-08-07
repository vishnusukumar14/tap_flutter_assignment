// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bond.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BondImpl _$$BondImplFromJson(Map<String, dynamic> json) => _$BondImpl(
  logo: json['logo'] as String,
  isin: json['isin'] as String,
  rating: json['rating'] as String,
  companyName: json['companyName'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$$BondImplToJson(_$BondImpl instance) =>
    <String, dynamic>{
      'logo': instance.logo,
      'isin': instance.isin,
      'rating': instance.rating,
      'companyName': instance.companyName,
      'tags': instance.tags,
    };
