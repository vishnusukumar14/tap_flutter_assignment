import 'package:tap_flutter_assignment/features/home/domain/entities/company.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/company_detail.dart';

abstract class RemoteRepository {
  Future<List<Company>> getCompanies();

  Future<CompanyDetail> getCompanyDetail();
}
