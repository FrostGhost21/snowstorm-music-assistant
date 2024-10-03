import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:snowstorm_v2/types.dart';

part 'db.g.dart';

class Songs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
}

class Playlists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get playlists => text().map(const PlaylistConverter())();
}

@DriftDatabase(tables: [Songs, Playlists])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'songs');
  }

  void addSongs(SongsCompanion song) {
    into(songs).insert(song);
  }

  void addPlaylist(PlaylistsCompanion playlist) {
    into(playlists).insert(playlist);
  }

  Future<List<Song>> getSongs() {
    return select(songs).get();
  }
}
