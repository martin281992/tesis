import 'package:apptagit/src/models/cobroModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();

  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Cobros>> getPortalesCobro() {
    return _db.collection('Cobros').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Cobros.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> addCobro(Cobros cobro) {
    return _db.collection('Cobros').add(cobro.toMap());
  }
}
