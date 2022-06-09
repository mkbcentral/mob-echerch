import 'package:echurch/models/church.dart';

class ChurchEvent {
  int? id;
  String? title;
  String? description;
  String? cover_event_url;
  String? started_at_date;
  String? finished_at_date;
  String? started_at_time;
  String? finished_at_time;
  String? status;
  Church? church;

  ChurchEvent(
      {this.id,
      this.title,
      this.description,
      this.cover_event_url,
      this.started_at_date,
      this.finished_at_date,
      this.started_at_time,
      this.finished_at_time,
      this.status,
      this.church});

  factory ChurchEvent.fromJson(Map<String, dynamic> json) {
    return ChurchEvent(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        cover_event_url: json['cover_event_url'],
        started_at_date: json['started_at_date'],
        finished_at_date: json['finished_at_date'],
        started_at_time: json['started_at_time'],
        finished_at_time: json['finished_at_time'],
        status: json['status'],
        church: Church(
            id: json['church']['id'],
            name: json['church']['name'],
            abreviation: json['church']['abreviation'],
            pastor_name: json['church']['pastor_name'],
            email: json['church']['email'],
            phone: json['church']['phone'],
            logo_url: json['church']['logo_url'],
            status: json['church']['status']));
  }
}
