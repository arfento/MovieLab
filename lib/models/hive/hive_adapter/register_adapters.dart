import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_lab/models/hive/models/actor_preview.dart';
import 'package:movie_lab/models/hive/models/show_preview.dart';
import 'package:movie_lab/models/hive/models/user.dart';

void registerAdapters() {
  Hive.registerAdapter(ShowPreviewAdapter());
  Hive.registerAdapter(ActorPreviewAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
}
