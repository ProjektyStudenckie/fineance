import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/repositories/wallets_repository.dart';
import 'package:fineance/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FineanceList extends StatefulWidget {

  const FineanceList({Key? key,required this.walletRepository}) : super(key: key);
  final WalletRepository walletRepository;

  @override
  State<FineanceList> createState() => _FineanceListState();
}

class _FineanceListState extends State<FineanceList> {

  List<Wallet> items = List.empty();

  _FineanceListState(){
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_){
      _asyncMethodLoad();
    });
  }

  _asyncMethodLoad() async {
    final download= await widget.walletRepository.downloadWallets();
    if(download){
      print('KOZAK dostalem wallety');
      print(widget.walletRepository.wallets.length);
      items = widget.walletRepository.wallets;
    }
  }

  _asyncMethodDelete(Wallet wallet) async {
    final download= await widget.walletRepository.removeWallet(wallet);
    if(download){
      print('KOZAK wyjebalem walletdostalem wallety');
      items = widget.walletRepository.wallets;
    }
  }



  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Slidable(
          key: Key(item.name),
          startActionPane: _buildSwipeActionRight(index),
          endActionPane: _buildSwipeActionLeft(index),
          child: _buildTile(item.name),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 0.8,
        color: context.isDarkTheme ? AppColors.white : AppColors.grey,
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
    final String _itemName = items[index].name;
    setState(() => items.removeAt(index));
    WidgetsBinding.instance!.addPostFrameCallback((_){
      _asyncMethodDelete(items[index]);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$_itemName dismissed')));
  }

  void _onEdit(int index) {}
}

class DismissBackground extends StatelessWidget {
  const DismissBackground({
    this.isPrimaryBackground = true,
    Key? key,
  }) : super(key: key);
  final bool isPrimaryBackground;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: isPrimaryBackground
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: const [
              Text(
                'Delete',
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              SizedBox(width: 5.0),
              Icon(
                Icons.delete_forever,
                size: 22.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
