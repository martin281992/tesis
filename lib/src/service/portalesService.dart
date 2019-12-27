import 'package:apptagit/src/models/cobroModel.dart';
import 'package:apptagit/src/models/portalesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();

  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Portal>> getPortales() {
    return _db.collection('portales').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Portal.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
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

  Future<void> addPortal(Portal portal) {
    return _db.collection('portales').add(portal.toMap());
  }

  Future<void> deletePortal(String id) {
    return _db.collection('portales').document(id).delete();
  }

  Future<void> updatePortal(Portal portal) {
    return _db
        .collection('portales')
        .document(portal.id)
        .updateData(portal.toMap());
  }

  Future<void> addCobro(Cobros cobro) {
    return _db.collection('Cobros').add(cobro.toMap());
  }
}
