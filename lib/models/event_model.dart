class EventModel {
  final int id;
  final String title;
  final String? desc;
  final String? location;
  final String startAt;
  final String? createdAt;

  EventModel({
    required this.id,
    required this.title,
    this.desc,
    this.location,
    required this.startAt,
    this.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"],
      title: json["title"],
      desc: json["desc"],
      location: json["location"],
      startAt: json["startAt"],
      createdAt: json["createdAt"],
    );
  }
}
