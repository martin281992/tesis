import 'package:apptagit/src/cloudstore/cobros.dart';
import 'package:apptagit/src/cloudstore/sociosCloud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();

  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Socios>> getSocios(data) {
    return _db
        .collection('socios')
        .where("encargado", isEqualTo: data)
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Socios.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> addSocio(Socios socio) {
    return _db.collection('socios').add(socio.toMap());
  }

  Future<void> deleteSocio(String id) {
    return _db.collection('socios').document(id).delete();
  }

  Future<void> updateSocio(Socios socio) {
    return _db
        .collection('socios')
        .document(socio.id)
        .updateData(socio.toMap());
  }
}
