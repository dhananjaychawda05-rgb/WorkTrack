// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core/theme/theme_cubit.dart' as _i596;
import '../core/utils/local_storage.dart' as _i471;
import '../features/auth/presentation/bloc/login_bloc.dart' as _i724;
import '../features/splash/cubit/splash_cubit.dart' as _i980;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i471.LocalStorage>(
      () => _i471.LocalStorageImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i596.ThemeCubit>(
      () => _i596.ThemeCubit(gh<_i471.LocalStorage>()),
    );
    gh.factory<_i724.LoginBloc>(
      () => _i724.LoginBloc(gh<_i471.LocalStorage>()),
    );
    gh.factory<_i980.SplashCubit>(
      () => _i980.SplashCubit(gh<_i471.LocalStorage>()),
    );
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
