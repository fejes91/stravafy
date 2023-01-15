import 'package:injectable/injectable.dart';
import 'package:stravafy/data/api/strava_client.dart';
import 'package:stravafy/data/holder/activity_holder.dart';
import 'package:stravafy/data/mapper/activity/activity_mapper.dart';
import 'package:stravafy/domain/action/activity_action.dart';

@Injectable(as: ActivityAction)
class ActivityActionImpl implements ActivityAction {
  final StravaClient _client;
  final ActivityHolder _holder;

  ActivityActionImpl(this._client, this._holder);

  @override
  Future<void> refreshActivities() async {
    final activities = (await _client.refreshActivities())
        .map((activityApiModel) => activityApiModel.toDomainModel())
        .toList();

    _holder.setActivities(activities);
    return;
  }
}
