import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl(this.supabase);

  @override
  Future<UserModel> login(String email, String password) async {
    final res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (res.user == null) {
      throw Exception("Login failed");
    }

    return UserModel.fromSupabase(res.user!);
  }
}
