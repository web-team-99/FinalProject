class ManualModel {
  String title;
  List<ManualEntry> entries;
  ManualModel({this.title, this.entries});
}

class ManualEntry {
  int id;
  String title;
  String description;
  String imageUrl;
  ManualEntry({this.id, this.title, this.description, this.imageUrl});
}
