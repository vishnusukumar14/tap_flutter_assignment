import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/bond_repository.dart';
import 'bond_detail_state.dart';

@injectable
class BondDetailCubit extends Cubit<BondDetailState> {
  final BondRepository _repository;

  BondDetailCubit(this._repository) : super(const BondDetailState.initial());

  Future<void> loadBondDetail() async {
    emit(const BondDetailState.loading());
    try {
      final bondDetail = await _repository.getCompanyDetail();
      emit(BondDetailState.loaded(bondDetail));
    } catch (error) {
      emit(BondDetailState.error(error.toString()));
    }
  }

  Future<void> refreshBondDetail() async {
    final currentState = state;

    if (currentState is BondDetailLoaded) {
      emit(BondDetailState.refreshing(currentState.bondDetail));
    }

    try {
      final bondDetail = await _repository.getCompanyDetail();
      emit(BondDetailState.loaded(bondDetail));
    } catch (error) {
      emit(BondDetailState.error(error.toString()));
    }
  }
}
