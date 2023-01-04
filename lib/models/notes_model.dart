import 'package:hive/hive.dart';
// mapping korar jonno generate korte hobe.
// g stands for generate
part 'notes_model.g.dart';

// hivetype er type id protita model er jonno vinno hote hobe

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
// hive field protita field er jonno vinno hobe
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;

  NotesModel({required this.title, required this.description});
}
