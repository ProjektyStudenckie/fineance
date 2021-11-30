import 'package:fineance/components/fineance_list.dart';
import 'package:fineance/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const FineanceList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
