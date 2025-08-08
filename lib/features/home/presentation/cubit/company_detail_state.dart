import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/company_detail.dart';

part 'company_detail_state.freezed.dart';

@freezed
class CompanyDetailState with _$CompanyDetailState {
  const factory CompanyDetailState.initial() = CompanyDetailInitial;

  const factory CompanyDetailState.loading() = CompanyDetailLoading;

  const factory CompanyDetailState.loaded(CompanyDetail companyDetail) =
      CompanyDetailLoaded;

  const factory CompanyDetailState.error(String message) = CompanyDetailError;

  const factory CompanyDetailState.refreshing(CompanyDetail previousData) =
      CompanyDetailRefreshing;
}
