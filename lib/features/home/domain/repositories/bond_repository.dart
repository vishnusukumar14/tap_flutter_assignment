import 'package:tap_flutter_assignment/features/home/domain/entities/bond.dart';

abstract class BondRepository {
  Future<List<Bond>> getCompanies();
}
