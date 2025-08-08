import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/company_repository.dart';
import 'company_list_state.dart';

@injectable
class CompanyListCubit extends Cubit<CompanyListState> {
  final RemoteRepository _repository;

  CompanyListCubit(this._repository) : super(const CompanyListState.initial());

  Future<void> loadCompanies() async {
    emit(const CompanyListState.loading());

    try {
      final companies = await _repository.getCompanies();
      emit(CompanyListState.loaded(companies));
    } catch (e) {
      emit(CompanyListState.error(e.toString()));
    }
  }
}
