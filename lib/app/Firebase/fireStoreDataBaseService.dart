import 'package:cloud_firestore/cloud_firestore.dart';

import 'fireStoreDataModel.dart';

const String TODO_COLLECTON_REF = "eviman";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _todosRef;

  DatabaseService() {
    _todosRef = _firestore.collection("eviman").withConverter<HelpCenter>(
        fromFirestore: (snapshots, _) => HelpCenter.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (todo, _) => todo.toJson());
  }

  Stream<QuerySnapshot> getTodos() {
    return _todosRef.snapshots();
  }

  void addTodo(HelpCenter todo) async {
    _todosRef.add(todo);
  }

  void updateTodo(String todoId, HelpCenter todo) {
    _todosRef.doc(todoId).update(todo.toJson());
  }

  void deleteTodo(String todoId) {
    _todosRef.doc(todoId).delete();
  }
}
