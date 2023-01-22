import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:stravafy/constants.dart';
import 'package:stravafy/core/model/view_model.dart';
import 'package:stravafy/domain/action/token_action.dart';
import 'package:stravafy/domain/store/token_store.dart';

@injectable
class AuthScreenVM extends ViewModel {
  final TokenAction _tokenAction;
  final TokenStore _tokenStore;

  @factoryMethod
  AuthScreenVM(this._tokenAction, this._tokenStore);

  Future<bool> get authenticated async =>
      (await _tokenStore.getAccessToken()) != null;

  Future<bool> authenticate() async {
    final result = await FlutterWebAuth.authenticate(
      url: stravaAuthUrl,
      callbackUrlScheme: stravaAuthRedirectScheme,
    );

    return handleAuthCode(result);
  }

  bool handleAuthCode(String url) {
    final code = Uri.parse(url).queryParameters['code'];

    if (code != null) {
      try {
        _tokenAction.refresh(code);
      } catch (e) {
        // todo log
        return false;
      }
      return true;
    } else {
      return false;
      // TODO error handling
    }
  }
}
