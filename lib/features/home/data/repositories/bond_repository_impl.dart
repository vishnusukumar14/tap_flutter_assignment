import 'package:injectable/injectable.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/bond.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/bond_detail.dart';

import '../../../../core/service/api_service.dart';
import '../../domain/repositories/bond_repository.dart';

@Injectable(as: BondRepository)
class CompanyRepositoryImpl implements BondRepository {
  final ApiService _apiService;

  CompanyRepositoryImpl(this._apiService);

  @override
  Future<List<Bond>> getCompanies() async {
    return await _apiService.getCompanies();
  }

  @override
  Future<BondDetail> getCompanyDetail() async {
    return await _apiService.getBondDetails();
  }
}
