import 'package:tap_flutter_assignment/features/home/domain/entities/bond.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/bond_detail.dart';

abstract class BondRepository {
  Future<List<Bond>> getCompanies();

  Future<BondDetail> getCompanyDetail();
}
