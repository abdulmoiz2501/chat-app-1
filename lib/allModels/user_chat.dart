import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ichat_app/allConstants/constants.dart';
import 'package:ichat_app/allConstants/firestore_constants.dart';

class UserChat {
  String id;
  String photoUrl;
  String nick;
  String about;
  String phone;

  UserChat({
    required this.id,
    required this.photoUrl,
    required this.nick,
    required this.about,
    required this.phone,
  });

  //To store data in firebase, Maps are used
  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickname: nick,
      FirestoreConstants.aboutMe: about,
      FirestoreConstants.phoneNumber: phone,
      FirestoreConstants.photoUrl: photoUrl,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.phoneNumber);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.nickname);
    } catch (e) {}
    return UserChat(
      id: doc.id,
      phone: phoneNumber,
      photoUrl: photoUrl,
      nick: nickname,
      about: aboutMe,
    );
  }
}
