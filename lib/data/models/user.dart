import 'dart:developer';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';


part 'user.g.dart';


// flutter pub run build_runner build
@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  User(this.name, this.email, this.phoneNumber);
  int? id;
  String name;
  String? email;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get profile {
    List<String> separated = [];
    name.split(' ').forEach((element) {
      element.split('-').forEach((element) { separated.add(element); });
    });
    return separated.map((e) => e[0]).take(3).join('').toUpperCase();
  }

  @override
  String toString() {
    return name;
  }

  static List<User> list (String? json) {
    try {
      return json == null ? [] : (jsonDecode(json) as List).map((i) => User.fromJson(i)).toList();
    }catch(e) { log("failed to convert response to list of users: $e"); }

    return [];
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    return (other is User) && (other.id == id);
  }
}