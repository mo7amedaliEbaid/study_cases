// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import 'data/data_sources/remote/tv_show.dart' as _i429;
import 'data/repositories/tv_shows.dart' as _i979;
import 'domain/use_cases/tv_shows.dart' as _i303;
import 'http_client.dart' as _i500;
import 'presentation/blocs/tv_shows/bloc.dart' as _i35;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i519.Client>(() => registerModule.httpClient);
    gh.factory<_i429.TvShowRemoteDataSourceImpl>(
        () => _i429.TvShowRemoteDataSourceImpl(gh<_i519.Client>()));
    gh.factory<_i979.TvShowRepositoryImpl>(() =>
        _i979.TvShowRepositoryImpl(gh<_i429.TvShowRemoteDataSourceImpl>()));
    gh.factory<_i303.GetMostPopularTvShows>(
        () => _i303.GetMostPopularTvShows(gh<_i979.TvShowRepositoryImpl>()));
    gh.factory<_i35.TvShowBloc>(
        () => _i35.TvShowBloc(gh<_i303.GetMostPopularTvShows>()));
    return this;
  }
}

class _$RegisterModule extends _i500.RegisterModule {}
