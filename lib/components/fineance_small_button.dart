import 'package:fineance/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceSmallButton extends StatelessWidget {
  const FineanceSmallButton({
    Key? key,
    required this.addGoal,
    required this.addRemittance,
  }) : super(key: key);

  final VoidCallback addGoal;
  final VoidCallback addRemittance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0, right: 8.0),
      child: SizedBox(
        width: 50.0,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )),
            backgroundColor: MaterialStateProperty.all<Color>(AppColors.blue),
          ),
          onPressed: () => AlertDialog(
            content: Column(
              children: [
                GestureDetector(onTap: addGoal, child: const Text('Add goal.')),
                GestureDetector(
                    onTap: addRemittance,
                    child: const Text('Add Income / Expense.')),
              ],
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    ); //,
    //);
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: [
              GestureDetector(onTap: addGoal, child: const Text('Add goal.')),
              GestureDetector(
                  onTap: addRemittance,
                  child: const Text('Add Income / Expense.')),
            ],
          ),
        );
      },
    );
  }
}
