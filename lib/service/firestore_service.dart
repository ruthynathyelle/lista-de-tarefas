import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:listadetarefas/model/tarefa_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Função para pegar a coleção de tarefas do usuário autenticado
  CollectionReference getTarefasCollection() {
    final User? usuario = _auth.currentUser;

    if (usuario != null) {
      return _firestore.collection('usuarios').doc(usuario.uid).collection('tarefas');
    } else {
      throw Exception('Usuário não autenticado');
    }
  }

  Future<void> addTarefa(Tarefa tarefa) async {
    final tarefasCollection = getTarefasCollection();
    await tarefasCollection.add(tarefa.toMap());
  }

  Future<void> deleteTarefa(String id) async {
    final tarefasCollection = getTarefasCollection();
    await tarefasCollection.doc(id).delete();
  }

  Future<void> updateTarefa(Tarefa tarefa) async {
    final tarefasCollection = getTarefasCollection();
    await tarefasCollection.doc(tarefa.id).update(tarefa.toMap());
  }

  Stream<List<Tarefa>> getTarefas() {
    final tarefasCollection = getTarefasCollection();
    return tarefasCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Tarefa.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}