class Church {
  int? id;
  String? name;
  String? abreviation;
  String? pastor_name;
  String? email;
  String? phone;
  String? logo_url;
  String? status;

  Church(
      {this.id,
      this.name,
      this.abreviation,
      this.pastor_name,
      this.email,
      this.phone,
      this.logo_url,
      this.status});

  factory Church.fromJson(Map<String, dynamic> json) {
    return Church(
        id: json['id'],
        name: json['name'],
        abreviation: json['abreviation'],
        pastor_name: json['pastor_name'],
        email: json['email'],
        phone: json['phone'],
        logo_url: json['logo_url'],
        status: json['status']);
  }
}
