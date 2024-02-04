// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

///
/// ----------------------[sign-in-model]--------//
///
class SignIn {
  final String email;
  final String password;
  SignIn({
    required this.email,
    required this.password,
  });

  SignIn copyWith({
    String? email,
    String? password,
  }) {
    return SignIn(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory SignIn.fromMap(Map<String, dynamic> map) {
    return SignIn(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignIn.fromJson(String source) =>
      SignIn.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SignIn(email: $email, password: $password)';

  @override
  bool operator ==(covariant SignIn other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
