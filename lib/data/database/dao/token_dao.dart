import 'package:floor/floor.dart';
import 'package:stravafy/data/database/model/token_data_model.dart';

@dao
abstract class TokenDao {
  @Query('SELECT * FROM TokenDataModel')
  Stream<TokenDataModel?> findToken();

  @insert
  Future<void> insertToken(TokenDataModel tokenDataModel);

  @Query('DELETE FROM TokenDataModel')
  Future<void> deleteToken();
}
