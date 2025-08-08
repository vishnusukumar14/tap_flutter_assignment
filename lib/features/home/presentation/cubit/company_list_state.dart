import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/company_detail.dart';

import '../../domain/entities/company.dart';

part 'company_list_state.freezed.dart';

@freezed
class CompanyListState with _$CompanyListState {
  const factory CompanyListState.initial() = CompanyListInitial;

  const factory CompanyListState.loading() = CompanyListLoading;

  const factory CompanyListState.loaded(List<Company> companies) =
      CompanyListLoaded;

  const factory CompanyListState.error(String message) = CompanyListError;
}
