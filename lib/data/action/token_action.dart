import 'package:injectable/injectable.dart';
import 'package:stravafy/data/api/strava_client.dart';
import 'package:stravafy/data/holder/token_holder.dart';
import 'package:stravafy/domain/action/token_action.dart';

@Injectable(as: TokenAction)
class TokenActionImpl extends TokenAction {
  final StravaClient _client;
  final TokenHolder _tokenHolder;

  TokenActionImpl(this._client, this._tokenHolder);

  @override
  Future<void> refresh(String tokenCode) async {
    final tokenApiModel = await _client.postTokenCode(tokenCode);
    // TODO store token in shared prefs
    // TODO store refresh token + expiry date
    // TODO implement token refresh
    _tokenHolder.setItem(tokenApiModel.accessToken);
  }
}
