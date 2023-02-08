import 'package:hive_flutter/adapters.dart';
import 'package:movie_lab/models/hive/hive_adapter/fields/user_fields.dart';
import 'package:movie_lab/models/hive/hive_adapter/hive_adapter.dart';
import 'package:movie_lab/models/hive/hive_adapter/hive_types.dart';
part 'user.g.dart';

@HiveType(typeId: HiveTypes.user, adapterName: HiveAdapters.user)
class HiveUser extends HiveObject {
  @HiveField(UserFields.name)
  late String name;
  @HiveField(UserFields.username)
  late String username;
  @HiveField(UserFields.imageUrl)
  late String imageUrl;

  // factory HiveUser.fromJson(Map<String, dynamic> json) {
  //   return HiveUser..name = json['name']..username = json['username']..imageUrl = json['imageUrl'];
  // }
}
