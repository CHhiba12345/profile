import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:profile/auth/controller_auth/auth_controller.dart';

final getItInstance = GetIt.I;

Future<void> setup() async {
  getItInstance
      .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getItInstance.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getItInstance.registerLazySingleton<AuthController>(
    () => AuthController(
      getItInstance(),
      getItInstance(),
    ),
  );
}
