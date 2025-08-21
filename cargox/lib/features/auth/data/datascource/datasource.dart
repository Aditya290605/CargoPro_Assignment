// data/sources/firebase_auth_source.dart
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseAuthSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  FirebaseAuthSource(this._auth, this._db);

  Future<void> ensureWebPersistenceIfNeeded() async {
    if (kIsWeb) {
      await _auth.setPersistence(Persistence.LOCAL);
    }
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<({String? verificationId, ConfirmationResult? confirmation})> sendOtp(
    String e164Phone,
  ) async {
    if (kIsWeb) {
      final confirmation = await _auth.signInWithPhoneNumber(e164Phone);
      return (verificationId: null, confirmation: confirmation);
    } else {
      String? vid;
      final completer =
          Completer<
            ({String? verificationId, ConfirmationResult? confirmation})
          >();
      await _auth.verifyPhoneNumber(
        phoneNumber: e164Phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential cred) async {
          // Auto-retrieval on Android
          await _auth.signInWithCredential(cred);
          completer.complete((verificationId: null, confirmation: null));
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          vid = verificationId;
          completer.complete((verificationId: vid, confirmation: null));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return completer.future;
    }
  }

  Future<UserCredential> verifyOtp({
    required String smsCode,
    String? verificationId,
    ConfirmationResult? confirmation,
  }) async {
    if (kIsWeb) {
      if (confirmation == null)
        throw FirebaseAuthException(code: 'missing-confirmation');
      return await confirmation.confirm(smsCode);
    } else {
      if (verificationId == null) {
        throw FirebaseAuthException(code: 'missing-verification-id');
      }
      final cred = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _auth.signInWithCredential(cred);
    }
  }

  Future<void> upsertUserDoc(User user) async {
    final ref = _db.collection('users').doc(user.uid);
    await ref.set({
      'uid': user.uid,
      'phoneNumber': user.phoneNumber,
      'displayName': user.displayName,
      'createdAt': FieldValue.serverTimestamp(),
      'lastLoginAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> signOut() => _auth.signOut();
}
