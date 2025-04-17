import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

/// Tabel users dengan kolom: id, username, email, password, user_type
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get username =>
      text().withLength(min: 3, max: 50).customConstraint('UNIQUE')();

  TextColumn get email =>
      text().withLength(min: 5, max: 100).customConstraint('UNIQUE')();

  TextColumn get password => text().withLength(min: 6, max: 100)();

  TextColumn get userType => text()
      .named('user_type')
      .customConstraint("CHECK(user_type IN ('organization','personal'))")();
}

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

/// Membuka koneksi ke file SQLite di folder aplikasi
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}
