import 'dart:io';

import 'package:mllp/data/vos/debit_vo.dart';

abstract class DebitDataAgent {
  Stream<List<DebitVO>> getAllDebits();

  Future<DebitVO> getDebitByID(int id);

  Future createDebit(DebitVO debitVO);

  Future<String> uploadFile(File file);

  Future<List<DebitVO>> getAllDebitsFuture();
}
