import 'package:hive_flutter/adapters.dart';
import 'package:movie_lab/models/hive/hive_adapter/fields/actor_preview_fields.dart';
import 'package:movie_lab/models/hive/hive_adapter/hive_adapter.dart';
import 'package:movie_lab/models/hive/hive_adapter/hive_types.dart';
import 'package:movie_lab/models/hive/models/show_preview.dart';
part 'actor_preview.g.dart';

@HiveType(
    typeId: HiveTypes.actorPreview, adapterName: HiveAdapters.actorPreview)
class HiveActorPreview extends HiveObject {
  @HiveField(ActorPreviewFields.id)
  final String id;
  @HiveField(ActorPreviewFields.name)
  final String name;
  @HiveField(ActorPreviewFields.image)
  final String image;
  @HiveField(ActorPreviewFields.asCharacter)
  final String asCharacter;
  @HiveField(ActorPreviewFields.knownFor)
  final List<HiveShowPreview> knownFor;
  @HiveField(ActorPreviewFields.birthDate)
  final String birthDate;
  @HiveField(ActorPreviewFields.deathDate)
  final String deathDate;
  @HiveField(ActorPreviewFields.height)
  final String height;

  HiveActorPreview(
      {required this.id,
      required this.name,
      required this.image,
      required this.asCharacter,
      required this.knownFor,
      required this.height,
      required this.birthDate,
      required this.deathDate});
}
