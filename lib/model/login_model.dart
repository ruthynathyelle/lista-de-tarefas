import 'package:listadetarefas/service/auth_service.dart';

class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  // Método para validar se o e-mail e a senha são válidos
  bool get isValid {
    return email.isNotEmpty && password.isNotEmpty;
  }

  // Método para realizar o login usando AuthService
  Future<void> login(AuthService authService) async {
    if (isValid) {
      try {
        await authService.login(email, password);
      } catch (e) {
        throw Exception('Erro ao fazer login: $e');
      }
    } else {
      throw Exception('Email e senha não podem estar vazios');
    }
  }

  // Método para enviar e-mail de recuperação de senha usando AuthService
  Future<void> resetPassword(AuthService authService) async {
    if (email.isNotEmpty) {
      try {
        await authService.resetPassword(email);
      } catch (e) {
        throw Exception('Erro ao enviar link de recuperação: $e');
      }
    } else {
      throw Exception('O e-mail não pode estar vazio');
    }
  }
}
