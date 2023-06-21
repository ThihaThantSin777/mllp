import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:mllp/constant/strings.dart';
import 'package:mllp/data/vos/debit_vo.dart';
import 'package:mllp/network/data_agent/debit_data_agent.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DebitDataAgentImpl extends DebitDataAgent {
  DebitDataAgentImpl._();

  static final DebitDataAgentImpl _singleton = DebitDataAgentImpl._();

  factory DebitDataAgentImpl() => _singleton;

  final _database = FirebaseDatabase.instance.ref();

  final _storage = FirebaseStorage.instance;

  @override
  Stream<List<DebitVO>> getAllDebits() =>
      _database.child(kDebitPath).onValue.map((event) {
        return event.snapshot.children.map((e) {
          return DebitVO.fromJson(Map<String, dynamic>.from(e.value as Map));
        }).toList();
      });

  @override
  Future<DebitVO> getDebitByID(int id) => _database
          .child(kDebitPath)
          .child(id.toString())
          .once()
          .asStream()
          .map((event) => event.snapshot)
          .map((snapshot) {
        return DebitVO.fromJson(
            Map<String, dynamic>.from(snapshot.value as Map));
      }).first;

  @override
  Future createDebit(DebitVO debitVO) => _database
      .child(kDebitPath)
      .child(debitVO.id.toString())
      .set(debitVO.toJson());

  @override
  Future<String> uploadFile(File file) => _storage
      .ref(kDebitPhotoPath)
      .child(DateTime.now().microsecondsSinceEpoch.toString())
      .putFile(file)
      .then((url) => url.ref.getDownloadURL());

  @override
  Future<List<DebitVO>> getAllDebitsFuture() => _database
          .child(kDebitPath)
          .once()
          .asStream()
          .map((event) => event.snapshot)
          .map((snapshot) {
        return DebitVO.fromJson(
            Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
}
