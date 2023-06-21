import 'package:flutter/material.dart';
import 'package:mllp/bloc/home_page_bloc.dart';
import 'package:mllp/constant/strings.dart';
import 'package:mllp/data/vos/debit_vo.dart';
import 'package:mllp/pages/add_debit_page.dart';
import 'package:mllp/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../view_items/home_page_view_items/home_page_view_items.dart';
import '../widgets/easy_text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (_) => HomePageBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.navigateToNextScreen(context, const AddDebitPage());
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const EasyText(
            fontWeight: FontWeight.w700,
            text: kAppName,
            color: kWhiteColor,
            fontSize: kFontSize15x,
          ),
        ),
        body: Selector<HomePageBloc, List<DebitVO>>(
            selector: (_, bloc) => bloc.getDebitList,
            builder: (_, debitList, __) => (debitList.isEmpty)
                ? const Center(
                    child: EasyText(
                      text: kNoDebitText,
                    ),
                  )
                : DebitCardItemView(debitList: debitList)),
      ),
    );
  }
}
