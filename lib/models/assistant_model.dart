class AssistantModel {
  final String id;
  final int created;
  final String root;

  AssistantModel({
    required this.id,
    required this.root,
    required this.created,
  });

  factory AssistantModel.fromJson(Map<String, dynamic> json) => AssistantModel(
    id: json["id"],
    root: json["root"],
    created: json["created"],
  );

  static List<AssistantModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => AssistantModel.fromJson(data)).toList();
  }
}
