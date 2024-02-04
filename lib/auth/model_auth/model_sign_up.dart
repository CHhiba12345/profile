// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:profile/auth/model_auth/model_sign_in.dart';

///
/// *****************[sign-up] model****************
///
class SignUp {
  final SignIn credentiel;
  final String phoneNumber;
  final String address;
  SignUp({
    required this.credentiel,
    required this.phoneNumber,
    required this.address,
  });

  SignUp copyWith({
    SignIn? credentiel,
    String? phoneNumber,
    String? address,
  }) {
    return SignUp(
      credentiel: credentiel ?? this.credentiel,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'credentiel': credentiel.toMap(),
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory SignUp.fromMap(Map<String, dynamic> map) {
    return SignUp(
      credentiel: SignIn.fromMap(map['credentiel'] as Map<String, dynamic>),
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUp.fromJson(String source) =>
      SignUp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SignUp(credentiel: $credentiel, phoneNumber: $phoneNumber, address: $address)';

  @override
  bool operator ==(covariant SignUp other) {
    if (identical(this, other)) return true;

    return other.credentiel == credentiel &&
        other.phoneNumber == phoneNumber &&
        other.address == address;
  }

  @override
  int get hashCode =>
      credentiel.hashCode ^ phoneNumber.hashCode ^ address.hashCode;
}
