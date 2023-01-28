// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stravafy_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorStravafyDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$StravafyDatabaseBuilder databaseBuilder(String name) =>
      _$StravafyDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$StravafyDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$StravafyDatabaseBuilder(null);
}

class _$StravafyDatabaseBuilder {
  _$StravafyDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$StravafyDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$StravafyDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<StravafyDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$StravafyDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$StravafyDatabase extends StravafyDatabase {
  _$StravafyDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TokenDao? _tokenDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TokenDataModel` (`id` INTEGER NOT NULL, `accessToken` TEXT NOT NULL, `refreshToken` TEXT NOT NULL, `expiresAt` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TokenDao get tokenDao {
    return _tokenDaoInstance ??= _$TokenDao(database, changeListener);
  }
}

class _$TokenDao extends TokenDao {
  _$TokenDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _tokenDataModelInsertionAdapter = InsertionAdapter(
            database,
            'TokenDataModel',
            (TokenDataModel item) => <String, Object?>{
                  'id': item.id,
                  'accessToken': item.accessToken,
                  'refreshToken': item.refreshToken,
                  'expiresAt': item.expiresAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TokenDataModel> _tokenDataModelInsertionAdapter;

  @override
  Stream<TokenDataModel?> findToken() {
    return _queryAdapter.queryStream('SELECT * FROM TokenDataModel',
        mapper: (Map<String, Object?> row) => TokenDataModel(
            accessToken: row['accessToken'] as String,
            refreshToken: row['refreshToken'] as String,
            expiresAt: row['expiresAt'] as int),
        queryableName: 'TokenDataModel',
        isView: false);
  }

  @override
  Future<void> deleteToken() async {
    await _queryAdapter.queryNoReturn('DELETE FROM TokenDataModel');
  }

  @override
  Future<void> insertToken(TokenDataModel tokenDataModel) async {
    await _tokenDataModelInsertionAdapter.insert(
        tokenDataModel, OnConflictStrategy.abort);
  }
}
