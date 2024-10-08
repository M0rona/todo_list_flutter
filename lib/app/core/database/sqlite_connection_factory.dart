import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';
import 'package:todo_list_provider/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  static const _version = 1;
  static const _databaseName = "TODO_LIST_PROVIDER";

  static SqliteConnectionFactory? _instance;

  Database? db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }

  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    var databasePathFinal = join(databasePath, _databaseName);

    if (db == null) {
      await _lock.synchronized(() async {
        db ??= await openDatabase(
          databasePathFinal,
          version: _version,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onDowngrade: _onDowgrade,
        );
      });
    }

    return db!;
  }

  void closeConnection() {
    db?.close();
    db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getCreateMigration();

    for (var migration in migrations) {
      migration.create(batch);
    }

    await batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {}
  Future<void> _onDowgrade(Database db, int oldVersion, int version) async {}
}
