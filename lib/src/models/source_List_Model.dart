import 'source_model.dart';

class SourceListModel {
  final List<SourceModel> sourcesList;

  SourceListModel({required this.sourcesList});

  factory SourceListModel.fromJsonList(List<dynamic> list) {
    List<SourceModel> sourcesList = list
        .map((source) => SourceModel(
              id: source['id'],
              sourceName: source['source_name'],
              notoriety: source['source_notoriety'],
              status: source['status'],
            ))
        .toList();

    return SourceListModel(sourcesList: sourcesList);
  }
  List<Map<String, dynamic>> toJsonList() {
    return List<Map<String, dynamic>>.from(
        sourcesList.map((source) => source.toJson()));
  }
}
