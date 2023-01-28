import 'package:injectable/injectable.dart';
import 'package:stravafy/data/api/model/token_api_model.dart';
import 'package:stravafy/data/api/strava_client.dart';
import 'package:stravafy/data/database/stravafy_database.dart';
import 'package:stravafy/data/mapper/token/token_mapper.dart';
import 'package:stravafy/domain/action/token_action.dart';

@Injectable(as: TokenAction)
class TokenActionImpl extends TokenAction {
  final StravaClient _client;
  final StravafyDatabase _database;

  TokenActionImpl(this._client, this._database);

  @override
  Future<void> getToken(String tokenCode) async {
    final tokenApiModel = await _client.postTokenCode(tokenCode);
    await _storeNewToken(tokenApiModel);
  }

  Future<void> _storeNewToken(TokenApiModel tokenApiModel) async {
    await _database.tokenDao.deleteToken();
    await _database.tokenDao.insertToken(tokenApiModel.toDataModel());
  }

  @override
  Future<bool> refreshToken() async {
    final tokenDataModel = await _database.tokenDao.findToken().first;
    if (tokenDataModel?.accessToken == null) {
      return false;
    }

    final expiresAt = (tokenDataModel?.expiresAt ?? 0) * 1000;
    final accessTokenExpired =
        DateTime.fromMillisecondsSinceEpoch(expiresAt).isBefore(DateTime.now());

    if (!accessTokenExpired) {
      return true;
    } else if (tokenDataModel?.refreshToken != null) {
      final tokenApiModel =
          await _client.refreshToken(tokenDataModel!.refreshToken);
      await _storeNewToken(tokenApiModel);
      return true;
    }

    return false;
  }
}
