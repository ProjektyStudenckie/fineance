import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FineanceList extends StatefulWidget {
  const FineanceList({Key? key}) : super(key: key);

  @override
  State<FineanceList> createState() => _FineanceListState();
}

class _FineanceListState extends State<FineanceList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Slidable(
              key: Key(item),
              startActionPane: _buildSwipeActionRight(index),
              endActionPane: _buildSwipeActionLeft(index),
              child: _buildTile(item),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            height: 0.8,
            color: context.isDarkTheme ? AppColors.white : AppColors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildTile(String title) => SizedBox(
        height: 75.0,
        child: Builder(
          builder: (context) => ListTile(
            title: Text(
              title,
              style: context.typo.main().copyWith(color: AppColors.white),
            ),
            tileColor:
                context.isDarkTheme ? AppColors.darkGrey : AppColors.grey,
            trailing: _buildTrailingIcon(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            onTap: () {
              final SlidableController? _slidable = Slidable.of(context);
              final bool _isClosed = _slidable!.closing;

              if (_isClosed) {
                _slidable.openCurrentActionPane();
              }
              _slidable.close();
            },
          ),
        ),
      );

  Widget _buildTrailingIcon() => const Icon(
        Icons.account_balance_wallet_rounded,
        size: 25.0,
        color: AppColors.blue,
      );

  ActionPane _buildSwipeActionRight(int index) => ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            autoClose: true,
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.black,
            icon: Icons.edit,
            label: 'Edit',
            onPressed: (context) => _onEdit(index),
          ),
        ],
      );

  ActionPane _buildSwipeActionLeft(int index) => ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            autoClose: true,
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.black,
            icon: Icons.delete_forever,
            label: 'Delete',
            onPressed: (context) => _onDismissed(index),
          ),
        ],
      );

  // TODO connect these functions with db
  void _onDismissed(int index) {
    final String _itemName = items[index];
    setState(() => items.removeAt(index));
    // TODO remove item from db
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$_itemName dismissed')));
  }

  void _onEdit(int index) {}
}

// mock data
final items = ['Horse', 'Cow', 'Camel', 'Sheep', 'Goat'];
