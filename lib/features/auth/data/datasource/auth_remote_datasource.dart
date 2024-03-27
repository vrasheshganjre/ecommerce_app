import 'dart:io';

import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:ecommerce/secrets/supabase_keys.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signInWithGoogle();
  Session? get getCurrentSession;
  Future<UserModel?> getCurrentUser();
  Stream<AuthState> get authState;
  Future<void> signOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImpl({
    required this.supabaseClient,
  });
  final _googleSignIn = GoogleSignIn(
    serverClientId: serverKeyGoogleSignIn,
  );
  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      _googleSignIn.signOut();
      final signIn = await _googleSignIn.signIn();
      if (signIn == null) {
        throw "Cannot sign in";
      }
      final googleAuth = await signIn.authentication;
      final accessToken = googleAuth.accessToken!;
      final idToken = googleAuth.idToken!;
      final response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      final user = UserModel(
        userId: response.session!.user.id,
        name: signIn.displayName ?? "",
        email: signIn.email,
        avatarurl: signIn.photoUrl ?? "",
        updatedAt: DateTime.now(),
      );
      final existingUser = await supabaseClient
          .from("profiles")
          .select()
          .eq('user_id', user.userId);
      if (existingUser.isNotEmpty) {
        // If the user exists, update their profile data
        await supabaseClient.from("profiles").update({
          'name': user.name,
          'avatar_url': user.avatarurl,
          'updated_at': user.updatedAt.toIso8601String(),
        }).eq('user_id', user.userId);
      } else {
        // If the user doesn't exist, insert a new record
        await supabaseClient.from("profiles").insert(user.toMap());
      }
      return user;
    } catch (e) {
      await _googleSignIn.signOut();
      await supabaseClient.auth.signOut();
      throw "Server error : ${e.toString()}";
    }
  }

  @override
  Session? get getCurrentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (getCurrentSession != null) {
        final user = await supabaseClient
            .from("profiles")
            .select()
            .eq('user_id', getCurrentSession!.user.id);
        return UserModel.fromMap(user.first);
      }
      return null;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: "Error connecting to server");
      throw e.message;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Stream<AuthState> get authState => supabaseClient.auth.onAuthStateChange;

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
