import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sha_bank/models/tip_model.dart';
import 'package:sha_bank/services/auth_service.dart';
import 'package:sha_bank/shared/shared_values.dart';

class TipService {
  Future<List<TipModel>> getTip() async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
        Uri.parse(
          '$baseUrl/tips',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<TipModel>.from(
          jsonDecode(res.body)['data'].map(
            (tip) => TipModel.fromJson(tip),
          ),
        ).toList();
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
