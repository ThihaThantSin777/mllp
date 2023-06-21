import 'dart:async';
import 'dart:io';

import 'package:mllp/data/apply/debit_apply.dart';
import 'package:mllp/data/vos/debit_vo.dart';
import 'package:mllp/network/data_agent/debit_data_agent.dart';
import 'package:mllp/network/data_agent/debit_data_agent_impl.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../persistent/debit_dao/debit_dao.dart';
import '../../persistent/debit_dao/debit_dao_impl.dart';

class DebitApplyImpl extends DebitApply {
  DebitApplyImpl._();

  static final DebitApplyImpl _singleton = DebitApplyImpl._();

  factory DebitApplyImpl() => _singleton;

  final DebitDataAgent _debitDataAgent = DebitDataAgentImpl();
  final DebitDAO _debitDAO = DebitDAOImpl();

  @override
  Future createDebit(DebitVO debitVO) => _debitDataAgent.createDebit(debitVO);

  @override
  StreamSubscription<List<DebitVO>> getAllDebits() {
    return _debitDataAgent.getAllDebits().listen((event) {
      if (event.isEmpty) {
        _debitDAO.clearBox();
      } else {
        _debitDAO.saveDebit(event);
      }
    });
  }

  @override
  Future<DebitVO> getDebitByID(int id) =>
      _debitDataAgent.getDebitByID(id).then((value) {
        _debitDAO.saveDebit([value]);
        return value;
      });

  @override
  Future<String> uploadFile(File file) => _debitDataAgent.uploadFile(file);

  @override
  Stream<DebitVO?> getDebitByIDFromDataBase(int id) => _debitDAO
      .watchDebitBox()
      .startWith(_debitDAO.getDebitVOByIDStream(id))
      .map((event) => _debitDAO.getDebitVOByID(id));

  @override
  Stream<List<DebitVO>?> getDebitListFromDataBase() => _debitDAO
      .watchDebitBox()
      .startWith(_debitDAO.getAllDebitStream())
      .map((event) => _debitDAO.getAllDebit());
}
