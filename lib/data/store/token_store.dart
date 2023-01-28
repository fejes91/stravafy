import 'package:injectable/injectable.dart';
import 'package:stravafy/data/database/stravafy_database.dart';
import 'package:stravafy/domain/store/token_store.dart';

@Injectable(as: TokenStore)
class TokenStoreImpl extends TokenStore {
  final StravafyDatabase _database;

  TokenStoreImpl(this._database);

  @override
  Stream<String?> getAccessToken() => _database.tokenDao.findToken().map(
        (tokenDataModel) => tokenDataModel?.accessToken,
      );
}
