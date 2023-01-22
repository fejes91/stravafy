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
import 'package:stravafy/data/holder/activity_holder.dart' as _i3;
import 'package:stravafy/data/holder/token_holder.dart' as _i6;
import 'package:stravafy/data/store/activity_store.dart' as _i5;
import 'package:stravafy/data/store/token_store.dart' as _i8;
import 'package:stravafy/di/modules/network_module.dart' as _i17;
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
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.singleton<_i3.ActivityHolder>(_i3.ActivityHolder());
    gh.factory<_i4.ActivityStore>(
        () => _i5.ActivityStoreImpl(gh<_i3.ActivityHolder>()));
    gh.factory<String>(() => networkModule.authEndpoint);
    gh.singleton<_i6.TokenHolder>(_i6.TokenHolder());
    gh.factory<_i7.TokenStore>(() => _i8.TokenStoreImpl(gh<_i6.TokenHolder>()));
    gh.singleton<_i9.Dio>(networkModule.provideDio(gh<_i7.TokenStore>()));
    gh.singleton<_i10.StravaClient>(
        networkModule.providStravaClient(gh<_i9.Dio>()));
    gh.factory<_i11.TokenAction>(() => _i12.TokenActionImpl(
          gh<_i10.StravaClient>(),
          gh<_i6.TokenHolder>(),
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

class _$NetworkModule extends _i17.NetworkModule {}
