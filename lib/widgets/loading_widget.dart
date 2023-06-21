import 'package:flutter/material.dart';
import 'package:mllp/constant/dimens.dart';
import 'package:mllp/constant/strings.dart';
import 'package:mllp/widgets/easy_text_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: kSP10x,
          ),
          EasyText(
            text: kLoadingText,
            fontSize: kFontSize17x,
            fontWeight: FontWeight.w700,
          )
        ],
      ),
    );
  }
}
