import 'package:injectable/injectable.dart';
import 'package:stravafy/data/holder/activity_holder.dart';
import 'package:stravafy/domain/model/activity.dart';
import 'package:stravafy/domain/store/activity_store.dart';

@Injectable(as: ActivityStore)
class ActivityStoreImpl implements ActivityStore {
  final ActivityHolder _holder;

  ActivityStoreImpl(this._holder);

  @override
  Stream<List<Activity>> getActivities() => _holder.activities;
}
