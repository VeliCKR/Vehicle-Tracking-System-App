import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user_data.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE Users (
      id INTEGER PRIMARY KEY,
      username TEXT,
      email TEXT
    )''');
  }

  // Kullanıcı ekleme
  Future<void> insertUser(String username, String email) async {
    final db = await database;
    await db.insert('Users', {'username': username, 'email': email});
  }

  // Kullanıcı doğrulama
  Future<bool> validateUser(String username, String email) async {
    final db = await database;
    final result = await db.query(
      'Users',
      where: 'username = ? AND email = ?',
      whereArgs: [username, email],
    );
    return result.isNotEmpty; // Eğer sonuç varsa, kullanıcı doğrulandı demektir.
  }
}
