import 'package:injectable/injectable.dart';
import 'package:stravafy/data/holder/base_holder.dart';
import 'package:stravafy/domain/model/activity.dart';

@singleton
class ActivityHolder extends BaseHolder<List<Activity>> {}
