import 'package:freezed_annotation/freezed_annotation.dart';

part 'bond.freezed.dart';
part 'bond.g.dart';

@freezed
class Bond with _$Bond {
  const factory Bond({
    required String logo,
    required String isin,
    required String rating,
    required String companyName,
    required List<String> tags,
  }) = _Bond;

  factory Bond.fromJson(Map<String, dynamic> json) => _$BondFromJson(json);
}
