import 'package:flutter/material.dart';
import 'package:listadetarefas/controller/tarefa_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TarefaController _controller = TarefaController();
  final TextEditingController _tituloController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // GlobalKey para o formulário

  @override
  void initState() {
    super.initState();
    _controller.carregarTarefas().listen((tarefas) {
      setState(() {
        // Atualiza a lista de tarefas de maneira segura
        _controller.tarefas = List.from(tarefas);
      });
    });
  }

  void _adicionarTarefa(String titulo) {
    setState(() {
      _controller.adicionarTarefa(titulo);
    });
  }

  void _alterarStatusTarefa(String id) {
    setState(() {
      _controller.alterarStatusTarefa(id);
    });
  }

  void _removerTarefa(String id) {
    setState(() {
      _controller.removerTarefa(id);
    });
  }

  void _editarTarefa(String id, String novoTitulo) {
    setState(() {
      _controller.editarTarefa(id, novoTitulo);
    });
  }

  void _mostrarDialogAdicionarTarefa() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Tarefa'),
          content: Form(
            key: _formKey, // Conecta o formulário ao GlobalKey
            child: TextFormField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título da Tarefa'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'O título não pode ser vazio';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Adicionar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) { // Verifica se o formulário é válido
                  final titulo = _tituloController.text;
                  _adicionarTarefa(titulo);
                  _tituloController.clear(); // Limpa o campo após adicionar
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text('Lista de Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _mostrarDialogAdicionarTarefa,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted){
              Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _controller.tarefas.length,
        itemBuilder: (context, index) {
          final tarefa = _controller.tarefas[index];
          return ListTile(
            title: Text(
              tarefa.titulo,
              style: TextStyle(
                decoration: tarefa.concluida
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: tarefa.concluida,
              onChanged: (bool? valor) {
                _alterarStatusTarefa(tarefa.id);
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editarTarefa(tarefa.id, tarefa.titulo);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _removerTarefa(tarefa.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
