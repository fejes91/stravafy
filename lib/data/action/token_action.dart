import 'package:injectable/injectable.dart';
import 'package:stravafy/data/api/strava_client.dart';
import 'package:stravafy/data/database/model/token_data_model.dart';
import 'package:stravafy/data/database/stravafy_database.dart';
import 'package:stravafy/domain/action/token_action.dart';

@Injectable(as: TokenAction)
class TokenActionImpl extends TokenAction {
  final StravaClient _client;
  final StravafyDatabase _database;

  TokenActionImpl(this._client, this._database);

  @override
  Future<void> refresh(String tokenCode) async {
    final tokenApiModel = await _client.postTokenCode(tokenCode);
    // TODO store token in shared prefs
    // TODO store refresh token + expiry date
    // TODO implement token refresh
    await _database.tokenDao.deleteToken();
    await _database.tokenDao
        .insertToken(TokenDataModel(tokenApiModel.accessToken));
  }
}
