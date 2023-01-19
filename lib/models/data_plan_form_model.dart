class DataPlanFormModel {
  final int? dataPlanId;
  final String? phoneNumber;
  final String? pin;

  DataPlanFormModel({
    this.dataPlanId,
    this.phoneNumber,
    this.pin,
  });

  Map<String, dynamic> toJson() {
    // to string karena error dari backend bukan int
    return {
      'data_plan_id': dataPlanId.toString(),
      'phone_number': phoneNumber,
      'pin': pin,
    };
  }
}
