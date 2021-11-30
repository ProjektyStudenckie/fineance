import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:fineance/style/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceList extends StatelessWidget {
  const FineanceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          confirmDismiss: (direction) async {
            // TODO remove item from list
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Dismissed'))); // TODO Add item name from db
            return true;
          },
          background: _dismissibleBackground(true),
          secondaryBackground: _dismissibleBackground(false),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.kMarginLargeDouble,
                vertical: Dimens.kMarginLarge),
            child: SizedBox(
              height: 75.0,
              child: ListTile(
                title: tileTitle(),
                tileColor: Colors.grey[800],
                trailing: trailingIcon(),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Dimens.kDefaultBorderRadius),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget tileTitle() => Text(
      'title',
      style: AppTypography().mainMediumBold().copyWith(
            color: AppColors.white,
          ),
    );

Widget trailingIcon() => const Icon(
      Icons.account_balance_wallet_outlined,
      size: 25.0,
      color: AppColors.blue,
    );

Widget _dismissibleBackground(bool isPrimaryBackground) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: isPrimaryBackground
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Text(
                'Delete',
                style: AppTypography().main().copyWith(color: AppColors.white),
              ),
              const SizedBox(width: 5.0),
              const Icon(
                Icons.delete_forever,
                size: 22.0,
              ),
            ],
          ),
        ),
      ),
    );
