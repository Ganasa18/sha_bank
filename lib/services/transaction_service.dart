import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sha_bank/models/data_plan_form_model.dart';
import 'package:sha_bank/models/top_up_form_model.dart';
import 'package:sha_bank/models/transaction_model.dart';
import 'package:sha_bank/models/transfer_form_model.dart';
import 'package:sha_bank/services/auth_service.dart';
import 'package:sha_bank/shared/shared_values.dart';

class TransactionService {
  Future<String> topUp(TopupFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrl/top_ups',
        ),
        headers: {
          "Authorization": token,
        },
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body)['redirect_url'];
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> transfer(TransferFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrl/transfers',
        ),
        headers: {
          "Authorization": token,
        },
        body: data.toJson(),
      );
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dataPlan(DataPlanFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrl/data_plans',
        ),
        headers: {
          "Authorization": token,
        },
        body: data.toJson(),
      );
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getTransaction() async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
        Uri.parse(
          '$baseUrl/transactions',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        List<TransactionModel> transactions = List<TransactionModel>.from(
          jsonDecode(res.body)['data'].map(
            (transaction) => TransactionModel.fromJson(transaction),
          ),
        ).toList();

        return transactions;
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
