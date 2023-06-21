import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mllp/bloc/add_debit_page_bloc.dart';
import 'package:mllp/bloc/home_page_bloc.dart';
import 'package:provider/provider.dart';

extension ContextExtexsion on BuildContext {
  AddDebitPageBloc getAddDebitPageBlocInstance() => read<AddDebitPageBloc>();
  HomePageBloc getHomePageBlocInstance() => read<HomePageBloc>();

  Future navigateToNextScreen(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => nextScreen));

  void navigateBack(BuildContext context) => Navigator.of(context).pop();
}

extension DateTimeExtensions on DateTime {
  String getFormatDate() => DateFormat('EEEE,dd y').format(this);

  String getYearMonthDayFormatDate() => DateFormat('yyyy,MM,dd').format(this);
}
