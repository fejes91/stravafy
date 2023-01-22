import 'package:injectable/injectable.dart';
import 'package:stravafy/data/holder/token_holder.dart';
import 'package:stravafy/domain/store/token_store.dart';

@Injectable(as: TokenStore)
class TokenStoreImpl extends TokenStore {
  final TokenHolder _tokenHolder;

  TokenStoreImpl(this._tokenHolder);

  @override
  Future<String?> getAccessToken() async => await _tokenHolder.item.first;
}
