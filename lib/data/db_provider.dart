// lib/data/db_provider.dart
import 'database.dart';

class DBProvider {
  // single instance
  static final AppDatabase _db = AppDatabase();

  // akses
  static AppDatabase get db => _db;
}
