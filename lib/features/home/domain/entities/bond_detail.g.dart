// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bond_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BondDetailImpl _$$BondDetailImplFromJson(Map<String, dynamic> json) =>
    _$BondDetailImpl(
      logo: json['logo'] as String,
      companyName: json['companyName'] as String,
      description: json['description'] as String,
      isin: json['isin'] as String,
      status: json['status'] as String,
      prosAndCons: ProsAndCons.fromJson(
        json['prosAndCons'] as Map<String, dynamic>,
      ),
      financials: Financials.fromJson(
        json['financials'] as Map<String, dynamic>,
      ),
      issuerDetails: IssuerDetails.fromJson(
        json['issuerDetails'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$BondDetailImplToJson(_$BondDetailImpl instance) =>
    <String, dynamic>{
      'logo': instance.logo,
      'companyName': instance.companyName,
      'description': instance.description,
      'isin': instance.isin,
      'status': instance.status,
      'prosAndCons': instance.prosAndCons,
      'financials': instance.financials,
      'issuerDetails': instance.issuerDetails,
    };

_$ProsAndConsImpl _$$ProsAndConsImplFromJson(Map<String, dynamic> json) =>
    _$ProsAndConsImpl(
      pros: (json['pros'] as List<dynamic>).map((e) => e as String).toList(),
      cons: (json['cons'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ProsAndConsImplToJson(_$ProsAndConsImpl instance) =>
    <String, dynamic>{'pros': instance.pros, 'cons': instance.cons};

_$FinancialsImpl _$$FinancialsImplFromJson(Map<String, dynamic> json) =>
    _$FinancialsImpl(
      ebitda: (json['ebitda'] as List<dynamic>)
          .map((e) => MonthlyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      revenue: (json['revenue'] as List<dynamic>)
          .map((e) => MonthlyData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FinancialsImplToJson(_$FinancialsImpl instance) =>
    <String, dynamic>{'ebitda': instance.ebitda, 'revenue': instance.revenue};

_$MonthlyDataImpl _$$MonthlyDataImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyDataImpl(
      month: json['month'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$$MonthlyDataImplToJson(_$MonthlyDataImpl instance) =>
    <String, dynamic>{'month': instance.month, 'value': instance.value};

_$IssuerDetailsImpl _$$IssuerDetailsImplFromJson(Map<String, dynamic> json) =>
    _$IssuerDetailsImpl(
      issuerName: json['issuerName'] as String,
      typeOfIssuer: json['typeOfIssuer'] as String,
      sector: json['sector'] as String,
      industry: json['industry'] as String,
      issuerNature: json['issuerNature'] as String,
      cin: json['cin'] as String,
      leadManager: json['leadManager'] as String,
      registrar: json['registrar'] as String,
      debentureTrustee: json['debentureTrustee'] as String,
    );

Map<String, dynamic> _$$IssuerDetailsImplToJson(_$IssuerDetailsImpl instance) =>
    <String, dynamic>{
      'issuerName': instance.issuerName,
      'typeOfIssuer': instance.typeOfIssuer,
      'sector': instance.sector,
      'industry': instance.industry,
      'issuerNature': instance.issuerNature,
      'cin': instance.cin,
      'leadManager': instance.leadManager,
      'registrar': instance.registrar,
      'debentureTrustee': instance.debentureTrustee,
    };
