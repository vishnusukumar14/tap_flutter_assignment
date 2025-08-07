import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/bond_detail.dart';

part 'bond_detail_state.freezed.dart';

@freezed
class BondDetailState with _$BondDetailState {
  const factory BondDetailState.initial() = BondDetailInitial;

  const factory BondDetailState.loading() = BondDetailLoading;

  const factory BondDetailState.loaded(BondDetail bondDetail) =
      BondDetailLoaded;

  const factory BondDetailState.error(String message) = BondDetailError;

  const factory BondDetailState.refreshing(BondDetail previousData) =
      BondDetailRefreshing;
}
