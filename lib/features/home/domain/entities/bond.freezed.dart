// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bond.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Bond _$BondFromJson(Map<String, dynamic> json) {
  return _Bond.fromJson(json);
}

/// @nodoc
mixin _$Bond {
  String get logo => throw _privateConstructorUsedError;
  String get isin => throw _privateConstructorUsedError;
  String get rating => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this Bond to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bond
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BondCopyWith<Bond> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BondCopyWith<$Res> {
  factory $BondCopyWith(Bond value, $Res Function(Bond) then) =
      _$BondCopyWithImpl<$Res, Bond>;
  @useResult
  $Res call({
    String logo,
    String isin,
    String rating,
    String companyName,
    List<String> tags,
  });
}

/// @nodoc
class _$BondCopyWithImpl<$Res, $Val extends Bond>
    implements $BondCopyWith<$Res> {
  _$BondCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bond
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logo = null,
    Object? isin = null,
    Object? rating = null,
    Object? companyName = null,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            logo: null == logo
                ? _value.logo
                : logo // ignore: cast_nullable_to_non_nullable
                      as String,
            isin: null == isin
                ? _value.isin
                : isin // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as String,
            companyName: null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BondImplCopyWith<$Res> implements $BondCopyWith<$Res> {
  factory _$$BondImplCopyWith(
    _$BondImpl value,
    $Res Function(_$BondImpl) then,
  ) = __$$BondImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String logo,
    String isin,
    String rating,
    String companyName,
    List<String> tags,
  });
}

/// @nodoc
class __$$BondImplCopyWithImpl<$Res>
    extends _$BondCopyWithImpl<$Res, _$BondImpl>
    implements _$$BondImplCopyWith<$Res> {
  __$$BondImplCopyWithImpl(_$BondImpl _value, $Res Function(_$BondImpl) _then)
    : super(_value, _then);

  /// Create a copy of Bond
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logo = null,
    Object? isin = null,
    Object? rating = null,
    Object? companyName = null,
    Object? tags = null,
  }) {
    return _then(
      _$BondImpl(
        logo: null == logo
            ? _value.logo
            : logo // ignore: cast_nullable_to_non_nullable
                  as String,
        isin: null == isin
            ? _value.isin
            : isin // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as String,
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BondImpl implements _Bond {
  const _$BondImpl({
    required this.logo,
    required this.isin,
    required this.rating,
    required this.companyName,
    required final List<String> tags,
  }) : _tags = tags;

  factory _$BondImpl.fromJson(Map<String, dynamic> json) =>
      _$$BondImplFromJson(json);

  @override
  final String logo;
  @override
  final String isin;
  @override
  final String rating;
  @override
  final String companyName;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Bond(logo: $logo, isin: $isin, rating: $rating, companyName: $companyName, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BondImpl &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.isin, isin) || other.isin == isin) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    logo,
    isin,
    rating,
    companyName,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of Bond
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BondImplCopyWith<_$BondImpl> get copyWith =>
      __$$BondImplCopyWithImpl<_$BondImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BondImplToJson(this);
  }
}

abstract class _Bond implements Bond {
  const factory _Bond({
    required final String logo,
    required final String isin,
    required final String rating,
    required final String companyName,
    required final List<String> tags,
  }) = _$BondImpl;

  factory _Bond.fromJson(Map<String, dynamic> json) = _$BondImpl.fromJson;

  @override
  String get logo;
  @override
  String get isin;
  @override
  String get rating;
  @override
  String get companyName;
  @override
  List<String> get tags;

  /// Create a copy of Bond
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BondImplCopyWith<_$BondImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
