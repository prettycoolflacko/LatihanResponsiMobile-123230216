import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user_model.dart';

class UserDatabase {
  UserDatabase._internal();

  static final UserDatabase instance = UserDatabase._internal();

  static const String _dbName = 'quiz_mobile.db';
  static const String _tableUsers = 'users';

  Database? _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $_tableUsers('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'name TEXT NOT NULL,'
      'username TEXT NOT NULL UNIQUE,'
      'password TEXT NOT NULL'
      ')',
    );
  }

  Future<int> insertUser(UserModel user) async {
    final Database db = await database;
    return db.insert(
      _tableUsers,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<UserModel?> getUserByUsername(String username) async {
    final Database db = await database;
    final List<Map<String, Object?>> maps = await db.query(
      _tableUsers,
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );
    if (maps.isEmpty) {
      return null;
    }
    return UserModel.fromMap(maps.first);
  }

  Future<UserModel?> validateUser(String username, String password) async {
    final Database db = await database;
    final List<Map<String, Object?>> maps = await db.query(
      _tableUsers,
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
      limit: 1,
    );
    if (maps.isEmpty) {
      return null;
    }
    return UserModel.fromMap(maps.first);
  }

  Future<bool> usernameExists(String username) async {
    final UserModel? user = await getUserByUsername(username);
    return user != null;
  }
}
