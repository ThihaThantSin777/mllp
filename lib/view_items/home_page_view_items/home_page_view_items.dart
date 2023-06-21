import 'package:flutter/material.dart';
import 'package:mllp/constant/colors.dart';
import 'package:mllp/constant/dimens.dart';
import 'package:mllp/constant/strings.dart';
import 'package:mllp/data/vos/debit_vo.dart';
import 'package:mllp/pages/add_debit_page.dart';
import 'package:mllp/utils/extensions.dart';

import '../../widgets/easy_text_widget.dart';

class DebitCardItemView extends StatelessWidget {
  const DebitCardItemView({Key? key, required this.debitList})
      : super(key: key);
  final List<DebitVO> debitList;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        context.getHomePageBlocInstance().refresh();
        return Future.value();
      },
      child: ListView.separated(
        itemCount: debitList.length,
        itemBuilder: (_, index) {
          return DebitCardView(debit: debitList[index]);
        },
        separatorBuilder: (_, index) => const SizedBox(
          height: kSP10x,
        ),
      ),
    );
  }
}

class DebitCardView extends StatelessWidget {
  const DebitCardView({Key? key, required this.debit}) : super(key: key);
  final DebitVO debit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          context.navigateToNextScreen(
              context,
              AddDebitPage(
                id: debit.id ?? -1,
              ));
        },
        leading: const Icon(
          Icons.check_circle,
          color: kBlueColor,
          size: kDoneDebitIconSize,
        ),
        title: EasyText(
          text: 'For ${debit.saveDate?.getFormatDate()} Debit',
          fontWeight: FontWeight.w600,
          fontSize: kFontSize15x,
        ),
        subtitle: EasyText(
          text: (debit.remark?.isEmpty ?? true)
              ? kNoRemarkText
              : debit.remark ?? '',
        ),
      ),
    );
  }
}
