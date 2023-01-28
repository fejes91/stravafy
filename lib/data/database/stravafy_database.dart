import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:stravafy/data/database/dao/token_dao.dart';
import 'package:stravafy/data/database/model/token_data_model.dart';

part 'stravafy_database.g.dart';

@Database(version: 1, entities: [TokenDataModel])
abstract class StravafyDatabase extends FloorDatabase {
  TokenDao get tokenDao;
}
