// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostModel {
  final String caption;
  final String proof;
  final String userLocation;
  final String userMail;
  final String userName;

  PostModel(
      {required this.caption,
      required this.proof,
      required this.userLocation,
      required this.userMail,
      required this.userName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'caption': caption,
      'proof': proof,
      'userLocation': userLocation,
      'userMail': userMail,
      'userName': userName,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
     caption:  map['caption'] ?? '',
     proof:  map['proof'] ?? '',
     userLocation:  map['userLocation'] ?? '',
     userMail:  map['userMail'] ?? '',
     userName:  map['userName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
