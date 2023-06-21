import 'package:flutter/material.dart';
import 'package:mllp/constant/colors.dart';
import 'package:mllp/constant/dimens.dart';
import 'package:mllp/constant/strings.dart';
import 'package:mllp/utils/extensions.dart';
import 'package:mllp/widgets/easy_text_widget.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({Key? key, required this.errorText})
      : super(key: key);
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const EasyText(text: kErrorText),
      content: EasyText(
        text: errorText,
        fontWeight: FontWeight.w700,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            context.navigateBack(context);
          },
          color: kBlueColor,
          child: const EasyText(text: kOKText),
        )
      ],
    );
  }
}
