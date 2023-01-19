import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sha_bank/models/sign_in_form_model.dart';
import 'package:sha_bank/models/sign_up_form_model.dart';
import 'package:sha_bank/shared/shared_values.dart';

import '../models/user_model.dart';

class AuthService {
// Check emaill boolean

  Future<bool?> checkEmail(String email) async {
    try {
      final res = await http.post(
        Uri.parse(
          '$baseUrl/is-email-exist',
        ),
        body: {
          'email': email,
        },
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body)['is_email_exist'];
      } else {
        var result = jsonDecode(res.body)['message'];
        // return jsonDecode(res.body)['message'];
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> register(SignUpForm data) async {
    log(data.toJson().toString());
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/register'),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        // print('$user from response');
        // print('${data.password} from auth provider');
        user = user.copyWith(password: data.password);
        await storeCredentialToLocal(user);
        return user;
      } else {
        // throw di gunakan untuk error untuk di tangkap di catch bloc
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(SignInFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/login'),
        body: data.toJson(),
      );

      var result = jsonDecode(res.body);

      if (res.statusCode == 200) {
        // var result = jsonDecode(res.body)['data']['user'];

        UserModel user = UserModel.fromJson(result);
        user = user.copyWith(password: data.password);

        await storeCredentialToLocal(user);
        return user;
      } else {
        // throw di gunakan untuk error untuk di tangkap di catch bloc
        // throw jsonDecode(res.body)['errors'];
        // print(jsonDecode(res.body)['errors']['password']);
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final token = await getToken();

      final res = await http.post(
          Uri.parse(
            '$baseUrl/logout',
          ),
          headers: {
            'Authorization': token,
          });

      if (res.statusCode == 200) {
        await clearLocalStorage();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
    } catch (e) {
      rethrow;
    }
  }

  Future<SignInFormModel> getCredentialFormLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['email'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {
        final SignInFormModel data = SignInFormModel(
          email: values['email'],
          password: values['password'],
        );

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = '';
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = 'Bearer $value';
    }

    return token;
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
