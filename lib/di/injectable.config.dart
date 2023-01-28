// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stravafy/data/action/activity_action.dart' as _i14;
import 'package:stravafy/data/action/token_action.dart' as _i12;
import 'package:stravafy/data/api/strava_client.dart' as _i10;
import 'package:stravafy/data/database/stravafy_database.dart' as _i6;
import 'package:stravafy/data/holder/activity_holder.dart' as _i3;
import 'package:stravafy/data/store/activity_store.dart' as _i5;
import 'package:stravafy/data/store/token_store.dart' as _i8;
import 'package:stravafy/di/modules/database_module.dart' as _i17;
import 'package:stravafy/di/modules/network_module.dart' as _i18;
import 'package:stravafy/domain/action/activity_action.dart' as _i13;
import 'package:stravafy/domain/action/token_action.dart' as _i11;
import 'package:stravafy/domain/store/activity_store.dart' as _i4;
import 'package:stravafy/domain/store/token_store.dart' as _i7;
import 'package:stravafy/screens/auth/auth_screen_vm.dart' as _i15;
import 'package:stravafy/screens/map/map_screen_vm.dart' as _i16;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final databaseModule = _$DatabaseModule();
    final networkModule = _$NetworkModule();
    gh.singleton<_i3.ActivityHolder>(_i3.ActivityHolder());
    gh.factory<_i4.ActivityStore>(
        () => _i5.ActivityStoreImpl(gh<_i3.ActivityHolder>()));
    await gh.singletonAsync<_i6.StravafyDatabase>(
      () => databaseModule.provideMovieDatabase(),
      preResolve: true,
    );
    gh.factory<String>(() => networkModule.authEndpoint);
    gh.factory<_i7.TokenStore>(
        () => _i8.TokenStoreImpl(gh<_i6.StravafyDatabase>()));
    gh.factory<bool>(() => networkModule.needAuthHeader(gh<Uri>()));
    gh.singleton<_i9.Dio>(networkModule.provideDio(gh<_i7.TokenStore>()));
    gh.singleton<_i10.StravaClient>(
        networkModule.providStravaClient(gh<_i9.Dio>()));
    gh.factory<_i11.TokenAction>(() => _i12.TokenActionImpl(
          gh<_i10.StravaClient>(),
          gh<_i6.StravafyDatabase>(),
        ));
    gh.factory<_i13.ActivityAction>(() => _i14.ActivityActionImpl(
          gh<_i10.StravaClient>(),
          gh<_i3.ActivityHolder>(),
        ));
    gh.factory<_i15.AuthScreenVM>(() => _i15.AuthScreenVM(
          gh<_i11.TokenAction>(),
          gh<_i7.TokenStore>(),
        ));
    gh.factory<_i16.MapScreenVM>(() => _i16.MapScreenVM(
          gh<_i4.ActivityStore>(),
          gh<_i13.ActivityAction>(),
        ));
    return this;
  }
}

class _$DatabaseModule extends _i17.DatabaseModule {}

class _$NetworkModule extends _i18.NetworkModule {}
