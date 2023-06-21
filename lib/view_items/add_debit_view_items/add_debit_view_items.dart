import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mllp/bloc/add_debit_page_bloc.dart';
import 'package:mllp/constant/colors.dart';
import 'package:mllp/constant/dimens.dart';
import 'package:mllp/constant/strings.dart';
import 'package:mllp/utils/extensions.dart';
import 'package:mllp/widgets/easy_text_widget.dart';
import 'package:mllp/widgets/error_dialog_widget.dart';
import 'package:mllp/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class SaveButtonItemView extends StatelessWidget {
  const SaveButtonItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      color: kBlueColor,
      onPressed: () {
        showDialog(context: context, builder: (_) => const LoadingWidget());
        context.getAddDebitPageBlocInstance().saveDebit().then((value) {
          context.navigateBack(context);
          context.navigateBack(context);
        }).catchError((error) {
          context.navigateBack(context);
          showDialog(
              context: context,
              builder: (_) =>
                  const ErrorDialogWidget(errorText: kNoSelectImageText));
        });
      },
      child: const EasyText(
        text: kSaveText,
        color: kWhiteColor,
      ),
    );
  }
}

class ChooseDateItemView extends StatelessWidget {
  const ChooseDateItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AddDebitPageBloc, DateTime>(
      selector: (_, bloc) => bloc.getDateTime,
      builder: (_, selectDateTime, __) => MaterialButton(
        minWidth: double.infinity,
        color: kBlueColor,
        onPressed: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime.now().add(const Duration(days: 700)))
              .then((value) {
            if (value != null) {
              context.getAddDebitPageBlocInstance().setDate(value);
            }
          });
        },
        child: EasyText(
          text: selectDateTime.getYearMonthDayFormatDate(),
          color: kWhiteColor,
        ),
      ),
    );
  }
}

class RemarkItemView extends StatelessWidget {
  const RemarkItemView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return (id == -1)
        ? TextField(
            onChanged: (remark) {
              context.getAddDebitPageBlocInstance().setRemark(remark);
            },
            maxLines: kMaxLines,
            decoration: const InputDecoration(hintText: kRemarkText),
          )
        : Selector<AddDebitPageBloc, String>(
            selector: (_, bloc) => bloc.getRemark,
            builder: (_, remark, __) => EasyText(text: remark));
  }
}

class SelectImageItemView extends StatelessWidget {
  const SelectImageItemView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: kSelectImageHeight,
        child: (id == -1)
            ? Selector<AddDebitPageBloc, File?>(
                selector: (_, bloc) => bloc.getSelectFile,
                builder: (_, selectFile, __) => ((selectFile == null)
                    ? const NoSelectImageView()
                    : SelectImageView(selectImage: selectFile)))
            : const NetworkImageView());
  }
}

class NetworkImageView extends StatelessWidget {
  const NetworkImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AddDebitPageBloc, String>(
      selector: (_, bloc) => bloc.getImageFromNetworkURL,
      builder: (_, image, __) => (image.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () {
                context.getAddDebitPageBlocInstance().setShowDetails();
              },
              child: Image.network(
                image,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
    );
  }
}

class NoSelectImageView extends StatelessWidget {
  const NoSelectImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.getAddDebitPageBlocInstance().selectImage();
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: kBlack12Color),
              borderRadius: BorderRadius.circular(kSP10x)),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kSP10x),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add_circle_outline),
              SizedBox(
                height: kSP10x,
              ),
              EasyText(
                text: kNoSelectImageText,
                color: kBlack45Color,
              )
            ],
          )),
    );
  }
}

class SelectImageView extends StatelessWidget {
  const SelectImageView({Key? key, required this.selectImage})
      : super(key: key);
  final File selectImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.file(selectImage)),
        Positioned(
          right: kSP5x,
          top: kSP25x,
          child: IconButton(
              onPressed: () {
                context.getAddDebitPageBlocInstance().removeImage();
              },
              icon: const Icon(
                Icons.remove_circle,
                color: kRedColor,
                size: kRemoveIconSize,
              )),
        ),
      ],
    );
  }
}

class DetailsImageView extends StatelessWidget {
  const DetailsImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AddDebitPageBloc, String>(
      selector: (_, bloc) => bloc.getImageFromNetworkURL,
      builder: (_, image, __) => image.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(kSP10x),
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.4),
              child: (image.isEmpty)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : DetailsImageAndRemoveIconView(
                      image: image,
                    ),
            ),
    );
  }
}

class DetailsImageAndRemoveIconView extends StatelessWidget {
  const DetailsImageAndRemoveIconView({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: InteractiveViewer(
            child: Image.network(
              image,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                context
                    .getAddDebitPageBlocInstance()
                    .removeImage(isNetworkImage: true);
              },
              icon: const Icon(
                Icons.remove_circle,
                color: kRedColor,
                size: kRemoveIconSize,
              )),
        )
      ],
    );
  }
}
