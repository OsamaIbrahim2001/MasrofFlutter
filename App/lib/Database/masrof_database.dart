import 'package:my_project/Models/MasrofModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MasrofDatabase {
  static final MasrofDatabase _instance = MasrofDatabase._internal();
  Database? _database;

  MasrofDatabase._internal();

  factory MasrofDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'masrof.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE masrof(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            operationDate TEXT,
            value REAL,
            operationType TEXT,
            paymentType TEXT,
            reason TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<int> insertMasrof(Masrof masrof) async {
    final db = await database;
    return await db.insert('masrof', masrof.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Masrof>> getMasrofList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('masrof');
    return List.generate(maps.length, (i) => Masrof.fromMap(maps[i]));
  }

  Future<int> updateMasrof(Masrof masrof) async {
    final db = await database;
    return await db.update('masrof', masrof.toMap(),
        where: 'id = ?', whereArgs: [masrof.id]);
  }

  Future<int> deleteMasrof(int id) async {
    final db = await database;
    return await db.delete('masrof', where: 'id = ?', whereArgs: [id]);
  }
}
