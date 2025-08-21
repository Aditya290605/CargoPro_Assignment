import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String phoneNumber;
  final DateTime createdAt;
  final String? displayName;

  AppUser({
    required this.uid,
    required this.phoneNumber,
    required this.createdAt,
    this.displayName,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'phoneNumber': phoneNumber,
    'createdAt': createdAt.toUtc(),
    'displayName': displayName,
  };

  factory AppUser.fromMap(Map<String, dynamic> m) => AppUser(
    uid: m['uid'],
    phoneNumber: m['phoneNumber'],
    createdAt:
        (m['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now().toUtc(),
    displayName: m['displayName'],
  );
}
