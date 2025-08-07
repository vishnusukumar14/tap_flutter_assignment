import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/bond_detail.dart';

import '../../domain/entities/bond.dart';

part 'bond_list_state.freezed.dart';

@freezed
class BondListState with _$BondListState {
  const factory BondListState.initial() = BondListInitial;

  const factory BondListState.loading() = BondListLoading;

  const factory BondListState.loaded(
    List<Bond> bonds, {
    Bond? selectedBond,
    BondDetail? bondDetail,
  }) = BondListLoaded;

  // const factory BondListState.detailLoading() = BondDetailLoading;

  const factory BondListState.error(String message) = BondListError;
}
