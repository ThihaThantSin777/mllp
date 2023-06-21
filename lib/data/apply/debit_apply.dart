import 'dart:async';
import 'dart:io';

import '../vos/debit_vo.dart';

abstract class DebitApply {
  StreamSubscription<List<DebitVO>> getAllDebits();

  Future<DebitVO> getDebitByID(int id);

  Future createDebit(DebitVO debitVO);

  Future<String> uploadFile(File file);

  Stream<List<DebitVO>?> getDebitListFromDataBase();

  Stream<DebitVO?> getDebitByIDFromDataBase(int id);
}
