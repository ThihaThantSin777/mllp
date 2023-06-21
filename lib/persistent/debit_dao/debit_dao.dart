import 'package:mllp/data/vos/debit_vo.dart';

abstract class DebitDAO {
  void saveDebit(List<DebitVO> debitVOList);

  DebitVO? getDebitVOByID(int id);

  List<DebitVO>? getAllDebit();

  Stream watchDebitBox();

  Stream<List<DebitVO>?> getAllDebitStream();

  Stream<DebitVO?> getDebitVOByIDStream(int id);

  void clearBox();
}
