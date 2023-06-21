import 'package:flutter/foundation.dart';

import '../data/apply/debit_apply.dart';
import '../data/apply/debit_apply_impl.dart';
import '../data/vos/debit_vo.dart';

class HomePageBloc extends ChangeNotifier {
  ///State Variable
  bool _dispose = false;
  List<DebitVO> _debitList = [];

  ///Getter
  List<DebitVO> get getDebitList => _debitList;

  ///State Instance
  final DebitApply _debitApply = DebitApplyImpl();

  HomePageBloc() {
    _debitApply.getAllDebits();

    _debitApply.getDebitListFromDataBase().listen((event) {
      if (event?.isNotEmpty ?? false) {
        _debitList = event ?? [];
        notifyListeners();
      }
    });
  }

  void refresh() => _debitApply.getAllDebits();

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }
}
