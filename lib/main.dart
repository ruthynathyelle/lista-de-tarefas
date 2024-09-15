import 'package:flutter/material.dart';
import 'package:listadetarefas/view/cadastro_page.dart';
import 'package:listadetarefas/view/home_page.dart';
import 'package:listadetarefas/view/login_page.dart'; 
import 'package:listadetarefas/service/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade100),
        useMaterial3: true,
      ),

       initialRoute: '/login', 
      // Definindo as rotas
      routes: {
        
        '/home': (context) => HomePage(),
        '/login': (context) =>  LoginPage(), 
        '/register': (context) => RegisterPage(),  // Rotas adicionais
      },
    );
  }
}
