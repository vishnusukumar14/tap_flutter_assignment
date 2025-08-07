import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/bond_repository.dart';
import 'bond_list_state.dart';

@injectable
class BondCubit extends Cubit<BondListState> {
  final BondRepository _repository;

  BondCubit(this._repository) : super(const BondListState.initial());

  Future<void> loadBonds() async {
    emit(const BondListState.loading());

    try {
      final companies = await _repository.getCompanies();
      emit(BondListState.loaded(companies));
    } catch (e) {
      emit(BondListState.error(e.toString()));
    }
  }

  void clearSelection() {
    if (state is BondListLoaded) {
      final currentState = state as BondListLoaded;
      // emit(currentState.copyWith(selectedCompany: null));
    }
  }
}
