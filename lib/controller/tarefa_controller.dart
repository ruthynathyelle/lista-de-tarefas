import 'package:listadetarefas/model/tarefa_model.dart';
import 'package:listadetarefas/service/firestore_service.dart';

class TarefaController {
  final FirestoreService _firestoreService = FirestoreService();

  List<Tarefa> tarefas = [];

  void adicionarTarefa(String titulo) {
    final tarefa = Tarefa(id: '', titulo: titulo, concluida: false, uid: '');
    _firestoreService.addTarefa(tarefa);
  }

  void alterarStatusTarefa(String id) {
    final tarefa = tarefas.firstWhere((t) => t.id == id);
    tarefa.concluida = !tarefa.concluida;
    _firestoreService.updateTarefa(tarefa);
  }

  void removerTarefa(String id) {
    _firestoreService.deleteTarefa(id);
  }

  void editarTarefa(String id, String novoTitulo) {
    final tarefa = tarefas.firstWhere((t) => t.id == id);
    tarefa.titulo = novoTitulo;
    _firestoreService.updateTarefa(tarefa);
  }

  Stream<List<Tarefa>> carregarTarefas() {
    return _firestoreService.getTarefas();
  }
}