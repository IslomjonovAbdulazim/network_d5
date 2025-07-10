class AlbumModel {
  late int id;
  late int userId;
  late String title;

  AlbumModel.fromJson(Map json) {
    id = json["id"];
    userId = json["userId"];
    title = json["title"];
  }
}