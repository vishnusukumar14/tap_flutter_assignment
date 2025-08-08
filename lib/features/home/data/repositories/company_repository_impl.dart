import 'package:injectable/injectable.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/company.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/company_detail.dart';

import '../../../../core/service/api_service.dart';
import '../../domain/repositories/company_repository.dart';

@Injectable(as: RemoteRepository)
class CompanyRepositoryImpl implements RemoteRepository {
  final ApiService _apiService;

  CompanyRepositoryImpl(this._apiService);

  @override
  Future<List<Company>> getCompanies() async {
    return await _apiService.getCompanies();
  }

  @override
  Future<CompanyDetail> getCompanyDetail() async {
    return await _apiService.getCompanyDetail();
  }
}
