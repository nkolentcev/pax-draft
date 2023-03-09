import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

class Users {
  String id;
  String name;
  int number;
  String uschema;

  Users(
      {required this.id,
      required this.name,
      required this.number,
      required this.uschema});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json["id"] as String,
        name: json['name'] as String,
        number: json['number'] as int,
        uschema: json['uschema'] as String);
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

Future<Users> GetUserByPin(int pin) async {
  var url = Uri.parse("http://213.27.32.24:8000/user/" + pin.toString());
  var response = await http.get(url);
  if (response.statusCode == 200) {
    return Users.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error :${response.reasonPhrase}');
  }
}
