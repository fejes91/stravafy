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

  Stream<bool> get authenticated =>
      _tokenStore.getAccessToken().map((token) => token != null);

  Future<void> authenticate() async {
    final result = await FlutterWebAuth.authenticate(
      url: stravaAuthUrl,
      callbackUrlScheme: stravaAuthRedirectScheme,
    );

    handleAuthCode(result);
  }

  void handleAuthCode(String url) {
    final code = Uri.parse(url).queryParameters['code'];

    if (code != null) {
      try {
        _tokenAction.refresh(code);
      } catch (e) {
        // todo log
      }
    } else {
      // TODO error handling
    }
  }
}
