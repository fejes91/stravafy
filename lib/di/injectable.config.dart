// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stravafy/data/action/activity_action.dart' as _i9;
import 'package:stravafy/data/api/strava_client.dart' as _i7;
import 'package:stravafy/data/holder/activity_holder.dart' as _i3;
import 'package:stravafy/data/store/activity_store.dart' as _i5;
import 'package:stravafy/di/modules/network_module.dart' as _i11;
import 'package:stravafy/domain/action/activity_action.dart' as _i8;
import 'package:stravafy/domain/store/activity_store.dart' as _i4;
import 'package:stravafy/screens/map/map_screen_vm.dart' as _i10;

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
    gh.singleton<_i6.Dio>(networkModule.provideDio());
    gh.singleton<_i7.StravaClient>(
        networkModule.providStravaClient(gh<_i6.Dio>()));
    gh.factory<_i8.ActivityAction>(() => _i9.ActivityActionImpl(
          gh<_i7.StravaClient>(),
          gh<_i3.ActivityHolder>(),
        ));
    gh.factory<_i10.MapScreenVM>(() => _i10.MapScreenVM(
          gh<_i4.ActivityStore>(),
          gh<_i8.ActivityAction>(),
        ));
    return this;
  }
}

class _$NetworkModule extends _i11.NetworkModule {}
