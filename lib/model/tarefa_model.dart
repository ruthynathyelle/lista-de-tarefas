class Tarefa {
  String id;
  String titulo;
  bool concluida;
  String uid;

  Tarefa({
    required this.id,
    required this.titulo,
    this.concluida = false,
    required this.uid,
  });

  // Convertendo o Firestore snapshot para o modelo Tarefa
  factory Tarefa.fromMap(Map<String, dynamic> data, String documentId) {
    return Tarefa(
      id: documentId,  // Atribuindo o ID do documento ao campo 'id'
      titulo: data['titulo'] ?? 'Sem título',  // Definindo título padrão caso seja nulo
      concluida: data['concluida'] ?? false,
      uid: data['uid'],
    );
  }

  // Convertendo o modelo Tarefa para Map para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      
      'titulo': titulo,  // Não inclui o ID, pois ele é gerado pelo Firestore
      'concluida': concluida,
      'uid': uid,
    };
  }
}
