import 'package:echurch/models/Church.dart';

class Preaching {
  int? id;
  String? title;
  String? predicator_name;
  String? cover_image_url;
  String? audio_file_url;
  String? status;
  String? audio_size;
  Church? church;

  Preaching(
      {this.id,
      this.title,
      this.predicator_name,
      this.cover_image_url,
      this.audio_file_url,
      this.audio_size,
      this.status,
      this.church});

  factory Preaching.fromJson(Map<String, dynamic> json) {
    return Preaching(
        id: json['id'],
        title: json['title'],
        predicator_name: json['predicator_name'],
        cover_image_url: json['cover_image_url'],
        audio_file_url: json['audio_file_url'],
        audio_size: json['audio_size'],
        status: json['status'],
        church: Church(
            id: json['id'],
            name: json['name'],
            abreviation: json['abreviation'],
            pastor_name: json['pastor_name'],
            email: json['email'],
            phone: json['phone'],
            logo_url: json['logo_url'],
            status: json['status']));
  }
}
