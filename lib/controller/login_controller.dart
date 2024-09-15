import 'package:firebase_auth/firebase_auth.dart';
import 'package:listadetarefas/model/login_model.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(LoginModel model) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      return userCredential.user;
    } catch (e) {
      // Lidar com erros, por exemplo, mostrar uma mensagem ao usuário
      print(e);
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
