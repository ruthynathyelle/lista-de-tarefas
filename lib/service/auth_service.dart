import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para fazer login
  Future<String> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return 'Login realizado com sucesso!';
      } else {
        return 'Falha ao realizar login.';
      }
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
  }

  // Método para criar um novo usuário
  Future<String> register(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return 'Cadastro realizado com sucesso!';
      } else {
        return 'Falha ao realizar cadastro.';
      }
    } catch (e) {
      throw Exception('Erro ao criar usuário: $e');
    }
  }

  // Método para recuperar a senha
  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'Link de recuperação de senha enviado para o e-mail.';
    } catch (e) {
      throw Exception('Erro ao enviar link de recuperação de senha: $e');
    }
  }

  // Método para fazer logout
  Future<String> logout() async {
    try {
      await _auth.signOut();
      return 'Logout realizado com sucesso!';
    } catch (e) {
      throw Exception('Erro ao fazer logout: $e');
    }
  }

  // Método para obter o usuário atual
  User? get currentUser => _auth.currentUser;
}
