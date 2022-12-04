class CheckJobStatusResponseModel {
  final int? code;
  final int? isProcess;
  final String? washId;
  final String? washTime;
  final String? amount;
  final String? paymentSourceType;
  final String? address;
  final String? machineLat;
  final String? machineLong;

  CheckJobStatusResponseModel({
    this.code,
    this.isProcess,
    this.washId,
    this.washTime,
    this.amount,
    this.paymentSourceType,
    this.address,
    this.machineLat,
    this.machineLong,
  });

  CheckJobStatusResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        isProcess = json['is_process'] as int?,
        washId = json['wash_id'] as String?,
        washTime = json['wash_time'] as String?,
        amount = json['amount'] as String?,
        paymentSourceType = json['payment_source_type'] as String?,
        address = json['address'] as String?,
        machineLat = json['machine_lat'] as String?,
        machineLong = json['machine_long'] as String?;

  Map<String, dynamic> toJson() => {
        'code': code,
        'is_process': isProcess,
        'wash_id': washId,
        'wash_time': washTime,
        'amount': amount,
        'payment_source_type': paymentSourceType,
        'address': address,
        'machine_lat': machineLat,
        'machine_long': machineLong,
      };
}
