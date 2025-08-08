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

import '../../features/home/data/repositories/company_repository_impl.dart'
    as _i246;
import '../../features/home/domain/repositories/company_repository.dart'
    as _i870;
import '../../features/home/presentation/cubit/company_detail_cubit.dart'
    as _i445;
import '../../features/home/presentation/cubit/company_list_cubit.dart'
    as _i451;
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
    gh.factory<_i870.RemoteRepository>(
      () => _i246.CompanyRepositoryImpl(gh<_i906.ApiService>()),
    );
    gh.factory<_i445.CompanyDetailCubit>(
      () => _i445.CompanyDetailCubit(gh<_i870.RemoteRepository>()),
    );
    gh.factory<_i451.CompanyListCubit>(
      () => _i451.CompanyListCubit(gh<_i870.RemoteRepository>()),
    );
    return this;
  }
}

class _$DioModule extends _i1045.DioModule {}
