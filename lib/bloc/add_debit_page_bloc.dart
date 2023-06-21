import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:mllp/constant/strings.dart';
import 'package:mllp/data/vos/debit_vo.dart';

import '../data/apply/debit_apply.dart';
import '../data/apply/debit_apply_impl.dart';

class AddDebitPageBloc extends ChangeNotifier {
  ///State Variable
  bool _dispose = false;

  ///State Instance
  final DebitApply _debitApply = DebitApplyImpl();

  File? _selectFile;
  String _remark = '';
  String _imageFromNetworkURL = '';
  bool _showDetails = false;
  DateTime _selectDateTime = DateTime.now();

  ///Getter
  File? get getSelectFile => _selectFile;

  String get getImageFromNetworkURL => _imageFromNetworkURL;

  String get getRemark => _remark;

  bool get isShowDetails => _showDetails;

  DateTime get getDateTime => _selectDateTime;
  AddDebitPageBloc({int id = -1}) {
    if (id != -1) {
      _debitApply.getDebitByID(id).then((value) {
        _imageFromNetworkURL = value.imageURL ?? '';
        _remark =
            (value.remark ?? '').isEmpty ? kNoRemarkText : value.remark ?? '';
        notifyListeners();
      });
    }
  }

  void setShowDetails() {
    _showDetails = !_showDetails;
    notifyListeners();
  }

  Future saveDebit() async {
    if (_selectFile == null) {
      return Future.error("Please select proof of result image!");
    }
    String imageURL = await _debitApply.uploadFile(_selectFile!);
    DebitVO debitVO = DebitVO(
        id: DateTime.now().microsecondsSinceEpoch,
        imageURL: imageURL,
        remark: _remark,
        saveDate: _selectDateTime);
    return _debitApply.createDebit(debitVO);
  }

  void selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _selectFile = File(result.files.single.path ?? '');
      notifyListeners();
    }
  }

  void removeImage({bool isNetworkImage = false}) {
    if (isNetworkImage) {
      _showDetails = false;
    } else {
      _selectFile = null;
    }

    notifyListeners();
  }

  void setDate(DateTime dateTime) {
    _selectDateTime = dateTime;
    notifyListeners();
  }

  void setRemark(String remark) {
    _remark = remark;
  }

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
