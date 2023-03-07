class UserModeller {
  String? id;
  String? name;
  int? number;
  String? uschema;

  UserModeller({this.id, this.name, this.number, this.uschema});

  UserModeller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    uschema = json['uschema'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    data['uschema'] = this.uschema;
    return data;
  }
}
