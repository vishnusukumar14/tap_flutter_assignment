import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/company_repository.dart';
import 'company_detail_state.dart';

@injectable
class CompanyDetailCubit extends Cubit<CompanyDetailState> {
  final RemoteRepository _repository;

  CompanyDetailCubit(this._repository)
    : super(const CompanyDetailState.initial());

  Future<void> loadCompanyDetail() async {
    emit(const CompanyDetailState.loading());
    try {
      final companyDetail = await _repository.getCompanyDetail();
      emit(CompanyDetailState.loaded(companyDetail));
    } catch (error) {
      emit(CompanyDetailState.error(error.toString()));
    }
  }

  Future<void> refreshCompanyDetail() async {
    final currentState = state;

    if (currentState is CompanyDetailLoaded) {
      emit(CompanyDetailState.refreshing(currentState.companyDetail));
    }

    try {
      final companyDetail = await _repository.getCompanyDetail();
      emit(CompanyDetailState.loaded(companyDetail));
    } catch (error) {
      emit(CompanyDetailState.error(error.toString()));
    }
  }
}
