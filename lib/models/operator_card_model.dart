import 'package:sha_bank/models/data_plan_model.dart';

class OperatorCardModel {
  final int? id;
  final String? name;
  final String? status;
  final String? thumbnail;
  final List<DataPlanModel>? dataPlans;

  OperatorCardModel({
    this.id,
    this.name,
    this.status,
    this.thumbnail,
    this.dataPlans,
  });

// map from list or array object data mengembalikan object di dalam object
  factory OperatorCardModel.fromJson(Map<String, dynamic> json) =>
      OperatorCardModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        thumbnail: json["thumbnail"],
        dataPlans: json["data_plans"] == null
            ? null
            : (json['data_plans'] as List)
                .map((dataPlan) => DataPlanModel.fromJson(dataPlan))
                .toList(),
      );
}
