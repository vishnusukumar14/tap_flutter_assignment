// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/home/data/repositories/bond_repository_impl.dart'
    as _i447;
import '../../features/home/domain/repositories/bond_repository.dart' as _i133;
import '../service/api_service.dart' as _i906;
import 'dio_module.dart' as _i1045;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i906.ApiService>(() => _i906.ApiService(gh<_i361.Dio>()));
    gh.factory<_i133.BondRepository>(
      () => _i447.CompanyRepositoryImpl(gh<_i906.ApiService>()),
    );
    return this;
  }
}

class _$DioModule extends _i1045.DioModule {}
