class PhoneVerificationModel {
  final int? code;
  final String? msg;
  final String? token;

  PhoneVerificationModel({
    this.code,
    this.msg,
    this.token,
  });

  PhoneVerificationModel.fromJson(Map<String, dynamic> json)
    : code = json['code'] as int?,
      msg = json['msg'] as String?,
      token = json['token'] as String?;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'msg' : msg,
    'token' : token
  };
}