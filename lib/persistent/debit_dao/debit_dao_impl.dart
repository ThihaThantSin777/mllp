import 'package:hive/hive.dart';
import 'package:mllp/constant/hive_constant.dart';
import 'package:mllp/data/vos/debit_vo.dart';

import 'debit_dao.dart';

class DebitDAOImpl extends DebitDAO {
  DebitDAOImpl._();

  static final DebitDAOImpl _singleton = DebitDAOImpl._();

  factory DebitDAOImpl() => _singleton;

  @override
  List<DebitVO>? getAllDebit() {
    final result = _getDebitBox().values.toList();
    result.sort((
      a,
      b,
    ) {
      DateTime date1 = a.saveDate ?? DateTime.now();
      DateTime date2 = b.saveDate ?? DateTime.now();
      return date1.isAfter(date2) ? 1 : -1;
    });
    return result;
  }

  @override
  DebitVO? getDebitVOByID(int id) => _getDebitBox().get(id);

  @override
  void saveDebit(List<DebitVO> debitVOList) {
    for (DebitVO result in debitVOList) {
      _getDebitBox().put(result.id.toString(), result);
    }
  }

  Box<DebitVO> _getDebitBox() => Hive.box<DebitVO>(kBoxNameForDebitVO);

  @override
  Stream<List<DebitVO>?> getAllDebitStream() => Stream.value(getAllDebit());

  @override
  Stream<DebitVO?> getDebitVOByIDStream(int id) =>
      Stream.value(getDebitVOByID(id));

  @override
  Stream watchDebitBox() => _getDebitBox().watch();

  @override
  void clearBox() {
    _getDebitBox().clear();
  }
}
