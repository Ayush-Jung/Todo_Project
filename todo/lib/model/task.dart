class Task {
  String id;
  String title;
  String description;

  Task({this.description, this.title, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  Task.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData['id'];
    this.title = mapData['title'];
    this.description = mapData['description'];
  }
}
