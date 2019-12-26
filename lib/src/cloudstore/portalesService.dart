import 'package:apptagit/src/cloudstore/cobros.dart';
import 'package:apptagit/src/cloudstore/encargados.dart';
import 'package:apptagit/src/cloudstore/portales.dart';
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

  Stream<List<Portal>> getPortalesCobro(data) {
    return _db
        .collection('portales')
        .where("longitud", isEqualTo: data)
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Portal.fromMap(doc.data, doc.documentID),
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

  Future<void> addEncargado(Encargo cargo) {
    return _db.collection('encargados').add(cargo.toMap());
  }
}
