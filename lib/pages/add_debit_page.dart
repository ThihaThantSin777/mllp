import 'package:flutter/material.dart';
import 'package:mllp/bloc/add_debit_page_bloc.dart';
import 'package:mllp/constant/colors.dart';
import 'package:mllp/constant/dimens.dart';
import 'package:mllp/constant/strings.dart';
import 'package:mllp/widgets/easy_text_widget.dart';
import 'package:provider/provider.dart';

import '../view_items/add_debit_view_items/add_debit_view_items.dart';

class AddDebitPage extends StatelessWidget {
  const AddDebitPage({Key? key, this.id = -1}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddDebitPageBloc>(
      create: (_) => AddDebitPageBloc(id: id),
      child: Selector<AddDebitPageBloc, bool>(
        selector: (_, bloc) => bloc.isShowDetails,
        builder: (_, showDetails, __) => Scaffold(
          appBar: (showDetails)
              ? null
              : AppBar(
                  centerTitle: true,
                  title: EasyText(
                    text: (id == -1 ? kAddDebitText : kDetailsDebitText),
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor,
                    fontSize: kFontSize15x,
                  ),
                ),
          body: showDetails
              ? const DetailsImageView()
              : Padding(
                  padding: const EdgeInsets.all(kSP10x),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectImageItemView(
                          id: id,
                        ),
                        const SizedBox(
                          height: kSP10x,
                        ),
                        RemarkItemView(
                          id: id,
                        ),
                        const SizedBox(
                          height: kSP10x,
                        ),
                        (id == -1)
                            ? const ChooseDateItemView()
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: kSP10x,
                        ),
                        (id == -1)
                            ? const SaveButtonItemView()
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
